module Mousereco
  class PageviewsRepository
    class << self
      def create!(attributes)
        Mousereco::Pageview.transaction do
          visitor = Mousereco::Visitor.where(key: attributes[:visitor_key]).first_or_create!
          Mousereco::Pageview.where(key: attributes[:pageview_key], url: attributes[:url], visitor_id: visitor.id).
            first_or_create!(page_html: attributes[:page_html], window_width: attributes[:window_width],
                             window_height: attributes[:window_height], timestamp: attributes[:timestamp])
        end
      end
    end
  end
end