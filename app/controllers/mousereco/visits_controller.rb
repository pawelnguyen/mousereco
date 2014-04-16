module Mousereco
  class VisitsController < Mousereco::ApplicationController
    def index
      @visits = Mousereco::Visit.order("created_at DESC")
    end
  end
end