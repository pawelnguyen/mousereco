class Api::V1::ApplicationController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def options
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
    headers["Access-Control-Allow-Headers"] =
      %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
    head(:ok)
  end
end