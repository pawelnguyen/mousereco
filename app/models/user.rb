class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :trackable, :validatable
end
