module Mousereco
  class Visitor < ActiveRecord::Base
    has_many :pageviews, -> { order('timestamp ASC') }
    has_many :visits, -> { order('created_at ASC') }

    def add_pageview(pageview)
      if last_visit && last_visit.combinable?(pageview)
        last_visit.combine(pageview)
      else
        visits << Mousereco::Visit.create_with_pageview(pageview) and return true
      end
    end

    private

    def last_visit
      visits.last
    end
  end
end
