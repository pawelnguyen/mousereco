class PageviewsService
  class << self
    def create!(attributes)
      Pageview.transaction do
        visitor = Visitor.where(key: attributes[:visitor_key]).first_or_create!
        Pageview.where(key: attributes[:pageview_key], url: attributes[:url], visitor_id: visitor.id).
          first_or_create!(page_html: attributes[:page_html])
      end
    end
  end
end