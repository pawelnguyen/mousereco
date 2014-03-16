module Mousereco
  class EventsRepository
    class << self
      def create_collection(events_attributes, visitor_key, pageview_key)
        Mousereco::Event.transaction do
          visitor = Mousereco::Visitor.find_by_key(visitor_key)
          pageview = Mousereco::Pageview.where(key: pageview_key, visitor: visitor).first

          events_attributes.each do |event_attributes|
            event_attributes.merge!(pageview: pageview, type: code_to_type(event_attributes[:type]))
            Mousereco::Event.where(event_attributes).first_or_create!
          end
        end
      end

      def code_to_type(code)
        "Mousereco::#{code.capitalize}" if code.present?
      end
    end
  end
end