module Mousereco
  module PageviewHelper
    def max_if_zero(value)
      value == 0 ? '100%' : value
    end

    def next_pageview_path(pageview)
      next_pageview = pageview.next_pageview
      return unless next_pageview
      pageview_path(next_pageview)
    end
  end
end