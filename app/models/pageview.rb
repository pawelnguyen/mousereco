class Pageview < ActiveRecord::Base
  has_many :events, order: 'timestamp ASC'
end
