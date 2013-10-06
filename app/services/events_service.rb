class EventsService
  class << self
    def create_collection(events_attributes, visitor_key)
      events_attributes.each do |event_attributes|
        Event.transaction do
          visitor = Visitor.where(visitor_key: visitor_key).first_or_create!
          Event.where(timestamp: event_attributes[:timestamp], visitor_id: visitor.id).first_or_create!(event_attributes)
        end
      end
    end
  end
end