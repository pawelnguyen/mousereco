class EventsService
  class << self
    def create_collection(events_attributes, visitor_key)
      events_attributes.each do |event_attributes|
        Event.transaction do
          event = Event.where(timestamp: event_attributes[:timestamp]).first_or_create!(event_attributes)
          visitor = Visitor.where(visitor_key: visitor_key).first_or_create!
          visitor.events << event
          visitor.save!
        end
      end
    end
  end
end