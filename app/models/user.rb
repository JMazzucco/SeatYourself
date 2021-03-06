class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :name, presence: true
  validates :email, uniqueness: true
	validates :password, length: { minimum: 3 }
	validates :password, confirmation: true
  validates :password_confirmation, presence: true
	validates :time_zone,
  inclusion: {
    in: ActiveSupport::TimeZone.zones_map(&:name).keys
  }

	has_many :reservations
	has_many :reviews
	has_many :restaurants, through: :reservations
end
