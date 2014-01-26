module Mousereco
  class Event < ActiveRecord::Base
    belongs_to :pageview

    validates_presence_of :pageview

    after_initialize :set_default_type

    def set_default_type
      self.type ||= 'Mousereco::Click'
    end
  end
end
