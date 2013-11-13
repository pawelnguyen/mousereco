class Api::V1::EventsController < Api::V1::ApplicationController
  def create
    EventsService.create_collection(permitted_params[:events].values, permitted_params[:visitor_key], permitted_params[:pageview_key],
                                    permitted_params[:url])
    render json: {success: true}
  end

  protected
  def permitted_params
    params.permit(:url, :website_key, :visitor_key, :pageview_key, events: [:x, :y, :timestamp, :type])
  end
end