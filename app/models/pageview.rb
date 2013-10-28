class Pageview < ActiveRecord::Base
  has_many :events, -> { order('timestamp ASC') }
  has_many :clicks, -> { order('timestamp ASC') }
  has_many :mousemoves, -> { order('timestamp ASC') }
  has_many :scrolls, -> { order('timestamp ASC') }

  def events_json
    events.to_json(only: [:x, :y, :timestamp, :type])
  end
end
