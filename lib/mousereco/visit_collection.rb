module Mousereco
  class VisitCollection
    attr_reader :visitors

    def initialize(visitors = Mousereco::Visitor.all)
      @visitors = visitors
    end

    def visits
      @visits ||= sort(visitors.map(&:visits).flatten)
    end

    private

    def sort(visits, field = :created_at)
      visits.sort { |x,y| y.send(field) <=> x.send(field) }
    end
  end
end