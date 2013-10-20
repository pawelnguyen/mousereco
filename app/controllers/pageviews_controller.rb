class PageviewsController < InheritedResources::Base
  custom_actions resource: :page_html

  layout false, only: [:page_html]
end