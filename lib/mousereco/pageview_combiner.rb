module Mousereco
  class PageviewCombiner
    class << self
      def combine(pageviews)
        new(pageviews).combine
      end
    end
  end
end