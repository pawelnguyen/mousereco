module Mousereco
  class VisitCollection
    attr_reader :visitors

    def initialize(visitors = Mousereco::Visitor.all)
      @visitors = visitors
    end

    def visits
      @visits ||= visitors.map(&:visits).flatten.sort.reverse
    end
  end
end