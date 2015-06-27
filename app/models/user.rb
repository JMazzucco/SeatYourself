class User < ActiveRecord::Base
	validates :name, :email, :password, :password_confirmation, presence: true
	has_secure_password
	has_many :reservations
	has_many :restaurants, through: :reservations
end
