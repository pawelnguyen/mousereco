module Mousereco
  class PageviewsCombiner
    attr_reader :pageviews

    def initialize(pageviews, pageviews_container_class = Mousereco::Visit)
      @pageviews = pageviews
      @pageviews_container_class = pageviews_container_class
    end

    def combine
      visits
    end

    private

    def visits
      @visits ||= create_visits
    end

    def create_visits
      result = [pageviews_container_class.new([pageviews.first])]
      pageviews.each_cons(2) do |pageview_combinable, pageview_combined|
        if pageview_combinable.combinable?(pageview_combined)
          result.last.add_pageview(pageview_combined)
        else
          result << pageviews_container_class.new([pageview_combined])
        end
      end
      result
    end

    def pageviews_container_class
      @pageviews_container_class
    end

    class << self
      def combine(pageviews)
        new(pageviews).combine
      end
    end
  end
end