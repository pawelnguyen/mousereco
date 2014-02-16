module Mousereco
  class VisitorsController < Mousereco::ApplicationController
    def index
      @visitors = Visitor.all
    end
  end
end