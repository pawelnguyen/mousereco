class EventsService
  class << self
    def create_collection(events_attributes)
      events_attributes.each do |event_attributes|
        Event.where(timestamp: event_attributes[:timestamp]).first_or_create!(event_attributes)
      end
    end
  end
end