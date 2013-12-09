class VisitsService
  class << self
    def create!(visitor, current_pageview_timestamp)
      visitors_last_event = visitor.last_event
      if visitors_last_event.nil? || create_new_visit?(visitors_last_event.timestamp, current_pageview_timestamp)
        Calculatable::Visit.create!
      else
        visitors_last_event.pageview.visit
      end
    end

    protected
    def create_new_visit?(finish_timestamp, start_timestamp)
      finish_timestamp - start_timestamp < Calculatable::Visit::PAGEVIEWS_MAX_OFFSET
    end
  end
end