class Api::V1::PageviewsController < Api::V1::ApplicationController
  def preflight
    render json: {success: true, send_html: true}
  end
end