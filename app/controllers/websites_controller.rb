class WebsitesController < InheritedResources::Base
  protected

  def permitted_params
    params.permit(website: [:url])
  end
end