module Mousereco
  class Pageview < ActiveRecord::Base
    has_many :events, -> { order('timestamp ASC') }
    has_many :clicks, -> { order('timestamp ASC') }
    has_many :mousemoves, -> { order('timestamp ASC') }
    has_many :scrolls, -> { order('timestamp ASC') }
    belongs_to :visitor

    ALLOWED_COMBINING_OVERLAP = 5.minutes

    validates_presence_of :visitor

    def events_json
      events.to_json(only: [:x, :y, :timestamp, :type])
    end

    def combinable?(pageview)
      return false if pageview.start_timestamp.nil? || end_timestamp.nil?
      pageview.start_timestamp - end_timestamp < ALLOWED_COMBINING_OVERLAP.to_i
    end

    def start_timestamp
      first_event.timestamp unless first_event.nil?
    end

    def end_timestamp
      last_event.timestamp unless last_event.nil?
    end

    private
    def first_event
      events.try(:first)
    end

    def last_event
      events.try(:last)
    end
  end
end
