class Visitor < ActiveRecord::Base
  has_many :pageviews
  has_many :events, through: :pageviews
  has_many :clicks, through: :pageviews
  has_many :mousemoves, through: :pageviews
  has_many :onscrolls, through: :pageviews
end
