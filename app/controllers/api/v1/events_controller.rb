class Api::V1::EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    EventsService.create_collection(permitted_params[:events].values)
    render json: {success: true}
  end

  protected
  def permitted_params
    params.permit(:url, :user_key, :visitor_key, events: [:x, :y, :timestamp])
  end
end