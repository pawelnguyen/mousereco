module Mousereco
  class PageviewCombiner
    attr_reader :pageviews

    def initialize(pageviews)
      @pageviews = pageviews
    end

    def combine
      @visits ||= visits
    end

    private

    def visits
      []
    end

    class << self
      def combine(pageviews)
        new(pageviews).combine
      end
    end
  end
end