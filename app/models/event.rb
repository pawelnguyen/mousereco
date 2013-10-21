class Event < ActiveRecord::Base
  after_initialize :set_default_type

  def set_default_type
    self.type ||= 'Click'
  end
end
