class Api::V1::PageviewsController < Api::V1::ApplicationController
  def preflight
    render json: {success: true, send_html: true}
  end

  def create
    binding.pry
    PageviewsService.create!(permitted_params)
    render json: {success: true}
  end

  protected
  def permitted_params
    params.permit(:url, :user_key, :visitor_key, :pageview_key, :page_html)
  end
end