module Mousereco
  module Api
    module V1
      class EventsController < Mousereco::Api::V1::ApplicationController
        def create
          render json: {success: false} and return if permitted_params[:events].blank?
          permitted_params[:events].values.each do |event_params|
            CreateEvent.new(event_params, permitted_params[:pageview_key]).create
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