class Website < ActiveRecord::Base
  belongs_to :user
  include GenerateKey
end
