class Pageview < ActiveRecord::Base
  has_many :events, -> { order('timestamp ASC') }

  def events_json
    events.to_json(only: [:x, :y, :timestamp])
  end
end
