class Api::V1::PagesController < Api::V1::ApplicationController
  def preflight
    render json: {success: true}
  end

  protected
  def permitted_params
    params.permit(:url, :user_key, :visitor_key, :pageview_key, events: [:x, :y, :timestamp])
  end
end