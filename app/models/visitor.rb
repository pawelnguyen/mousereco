class Visitor < ActiveRecord::Base
  has_many :pageviews
  has_many :events, through: :pageviews
end
