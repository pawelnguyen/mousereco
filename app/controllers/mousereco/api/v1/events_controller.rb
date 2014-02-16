module Mousereco
  module Api
    module V1
      class EventsController < ApplicationController
        def create
          if permitted_params[:events].present?
            EventsService.create_collection(permitted_params[:events].values, permitted_params[:visitor_key], permitted_params[:pageview_key])
          end
          render json: {success: true}
        end

        protected
        def permitted_params
          params.permit(:url, :visitor_key, :pageview_key, events: [:x, :y, :timestamp, :type])
        end
      end
    end
  end
end