class WebsitesController < InheritedResources::Base
  before_filter :authenticate_user!
  load_and_authorize_resource

  protected

  def permitted_params
    params.permit(website: [:url])
  end

  def collection
    @websites = end_of_association_chain.where(user: current_user)
  end
end