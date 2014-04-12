module Mousereco
  class VisitCollection
    attr_reader :visitors

    def initialize(visitors = Visitor.all)
      @visitors = visitors
    end

    def visits
      @visits ||= visitors.map(&:visits)
    end
  end
end