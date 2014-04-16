module Mousereco
  class Visit < ActiveRecord::Base
    has_many :pageviews, -> { order('timestamp ASC') }
    belongs_to :visitor

    def combinable?(pageview)
      return false unless pageviews.last
      pageviews.last.combinable?(pageview)
    end

    def combine(pageview)
      pageviews << pageview and return true
    end

    def next_pageview_to(pageview, order_by = :timestamp)
      pageviews.where("#{order_by} > ?", pageview.send(order_by)).order("#{order_by} ASC").first
    end

    class << self
      def create_with_pageview(pageview)
        create(pageviews: [pageview])
      end
    end
  end
end
