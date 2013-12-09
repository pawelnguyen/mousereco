class Pageview < ActiveRecord::Base
  has_many :events, -> { order('timestamp ASC') }
  has_many :clicks, -> { order('timestamp ASC') }
  has_many :mousemoves, -> { order('timestamp ASC') }
  has_many :scrolls, -> { order('timestamp ASC') }
  belongs_to :website
  belongs_to :visit, class_name: Calculatable::Visit
  belongs_to :visitor

  validates_presence_of :visit, :website, :visitor

  def events_json
    events.to_json(only: [:x, :y, :timestamp, :type])
  end
end
