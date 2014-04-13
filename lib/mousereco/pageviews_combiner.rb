module Mousereco
  class PageviewsCombiner
    attr_reader :pageviews

    def initialize(pageviews)
      @pageviews = pageviews
    end

    def combine
      visits
    end

    private

    def visits
      @visits ||= create_visits
    end

    def create_visits
      result = [Mousereco::Visit.new([pageviews.first])]
      pageviews.each_cons(2) do |pageview_combinable, pageview_combined|
        if pageview_combinable.combinable?(pageview_combined)
          result.last.add_pageview(pageview_combined)
        else
          result << Mousereco::Visit.new([pageview_combined])
        end
      end
      result
    end

    class << self
      def combine(pageviews)
        new(pageviews).combine
      end
    end
  end

  Visit = Struct.new(:pageviews) do
    def add_pageview(pageview)
      pageviews << pageview
    end
  end
end