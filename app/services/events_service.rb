class EventsService
  class << self
    def create_collection(events_attributes, visitor_key, pageview_key)
      Event.transaction do
        visitor = Visitor.find_by_key(visitor_key)
        pageview = Pageview.where(key: pageview_key, visitor: visitor).first

        events_attributes.each do |event_attributes|
          event_attributes.merge!(pageview: pageview, type: event_attributes[:type].try(:capitalize))
          Event.where(event_attributes).first_or_create!
        end
      end
    end
  end
end