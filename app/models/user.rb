class User < ActiveRecord::Base
	has_many :reservations
	has_many :restaurants, through: :reservations
	has_secure_password
end
