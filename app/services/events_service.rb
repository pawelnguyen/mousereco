class EventsService
  class << self
    def create_collection(events_attributes, visitor_key, pageview_key, url)
      Event.transaction do
        visitor = Visitor.where(key: visitor_key).first_or_create!
        pageview = Pageview.where(key: pageview_key, url: url, visitor_id: visitor.id).first_or_create!

        events_attributes.each do |event_attributes|
          Event.where(timestamp: event_attributes[:timestamp], pageview_id: pageview.id).first_or_create!(event_attributes)
        end
      end
    end
  end
end