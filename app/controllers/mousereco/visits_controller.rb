module Mousereco
  class VisitsController < Mousereco::ApplicationController
    def index
      @visits = Mousereco::VisitCollection.new.visits
    end
  end
end