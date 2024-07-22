class Activity < ApplicationRecord
	belongs_to :user

	validates :starts_at, presence: true
end
