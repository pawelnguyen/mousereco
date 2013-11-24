class Website < ActiveRecord::Base
  belongs_to :user
  has_many :pageviews
  include GenerateKey

  validates :url, format: {with: URI::regexp}
  validates :url, uniqueness: true
end
