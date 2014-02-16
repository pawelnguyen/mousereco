module Mousereco
  class PageviewsController < Mousereco::ApplicationController
    layout false, only: [:page_html]

    def page_html
      @pageview = Pageview.find(params[:id])
    end

    def show
      @pageview = Pageview.find(params[:id])
    end
  end
end