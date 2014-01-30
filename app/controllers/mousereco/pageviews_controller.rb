module Mousereco
  class PageviewsController < Mousereco::ApplicationController
    inherit_resources
    custom_actions resource: :page_html

    layout false, only: [:page_html]
  end
end