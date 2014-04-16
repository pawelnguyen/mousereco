module Mousereco
  class CreateEvent
    attr_reader :event_params, :pageview_key
    def initialize(event_params, pageview_key)
      @event_params, @pageview_key = event_params, pageview_key
    end

    def create
      Mousereco::Event.where(event_attributes).first_or_create!
    end

    private

    def pageview
      @pageview ||= Mousereco::Pageview.where(key: pageview_key).first
    end

    def event_attributes
      event_params.merge!(pageview: pageview, type: code_to_type(event_params[:type]))
    end

    def code_to_type(code)
      "Mousereco::#{code.capitalize}" if code.present?
    end
  end
end