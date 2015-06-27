class Restaurant < ActiveRecord::Base
	validates :name, :address, :cuisine_type, :website, presence: true
	has_many :reservations
	has_many :users, through: :reservations
end
