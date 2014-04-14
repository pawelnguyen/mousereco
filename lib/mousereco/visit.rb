module Mousereco
  class Visit
    attr_reader :pageviews
    def initialize(pageviews = [])
      @pageviews = pageviews
    end

    def add_pageview(pageview)
      pageviews << pageview
    end

    def start_timestamp
      pageviews.first.start_timestamp if pageviews.first
    end
  end
end