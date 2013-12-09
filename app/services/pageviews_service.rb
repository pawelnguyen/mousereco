class PageviewsService
  class << self
    def create!(attributes)
      Pageview.transaction do
        website = Website.find_by_key(attributes[:website_key])
        visitor = Visitor.where(key: attributes[:visitor_key]).first_or_create!
        visit = VisitsService.create!(visitor, attributes[:timestamp])
        Pageview.where(key: attributes[:pageview_key], url: attributes[:url], visitor_id: visitor.id, website_id: website.id, visit_id: visit.id).
          first_or_create!(page_html: attributes[:page_html], window_width: attributes[:window_width],
                           window_height: attributes[:window_height], timestamp: attributes[:timestamp])
      end
    end
  end
end