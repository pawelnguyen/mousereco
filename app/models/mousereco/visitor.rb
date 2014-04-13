module Mousereco
  class Visitor < ActiveRecord::Base
    has_many :pageviews
    has_many :events, through: :pageviews
    has_many :clicks, through: :pageviews
    has_many :mousemoves, through: :pageviews
    has_many :scrolls, through: :pageviews

    def last_event
      events.order('timestamp ASC').last
    end

    def visits
      Mousereco::PageviewsCombiner.combine(pageviews)
    end
  end
end
