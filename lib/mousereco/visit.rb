module Mousereco
  class Visit
    include Comparable

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

    def <=> other
      start_timestamp.to_i <=> other.start_timestamp.to_i
    end
  end
end