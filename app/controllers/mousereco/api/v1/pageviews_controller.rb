module Mousereco
  module Api
    module V1
      class PageviewsController < Mousereco::Api::V1::ApplicationController
        def preflight
          render json: {success: true, send_html: true}
        end

        def create
          PageviewsRepository.create!(permitted_params)
          render json: {success: true}
        end

        protected
        def permitted_params
          params.permit(:url, :visitor_key, :pageview_key, :page_html, :window_height, :window_width, :timestamp)
        end
      end
    end
  end
end