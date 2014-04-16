module Mousereco
  class CreatePageview
    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def create
      visitor = Mousereco::Visitor.where(key: attributes[:visitor_key]).first_or_create!
      pageview = Mousereco::Pageview.create(pageview_attributes)
      visitor.add_pageview(pageview)
    end

    private

    def pageview_attributes
      {key: attributes[:pageview_key], url: attributes[:url], page_html: attributes[:page_html],
       window_width: attributes[:window_width], window_height: attributes[:window_height],
       timestamp: attributes[:timestamp]}
    end
  end
end