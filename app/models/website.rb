class Website < ActiveRecord::Base
  belongs_to :user
  has_many :pageviews
  include GenerateKey
end
