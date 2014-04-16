module Mousereco
  class Pageview < ActiveRecord::Base
    has_many :events, -> { order('timestamp ASC') }
    has_many :clicks, -> { order('timestamp ASC') }
    has_many :mousemoves, -> { order('timestamp ASC') }
    has_many :scrolls, -> { order('timestamp ASC') }
    belongs_to :visit

    delegate :visitor, to: :visit

    ALLOWED_COMBINING_OVERLAP = 5.minutes

    def events_json
      events.to_json(only: [:x, :y, :timestamp, :type])
    end

    def combinable?(pageview)
      return false if pageview.start_timestamp.nil? || end_timestamp.nil?
      (pageview.start_timestamp - end_timestamp).abs < ALLOWED_COMBINING_OVERLAP.to_i * 1000
    end

    def start_timestamp
      timestamp
    end

    def end_timestamp
      (last_event.timestamp unless last_event.nil?) || start_timestamp
    end

    def next_pageview
      visit.next_pageview_to(self) if visit
    end

    private
    def last_event
      events.try(:last)
    end
  end
end
