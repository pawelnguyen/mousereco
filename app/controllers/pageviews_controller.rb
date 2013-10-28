class PageviewsController < InheritedResources::Base
  before_filter :authenticate_user!
  custom_actions resource: :page_html

  layout false, only: [:page_html]
end