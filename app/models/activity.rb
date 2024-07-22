class Activity < ApplicationRecord
	belongs_to :user

	validates :title, presence: true
	validates :starts_at, presence: true
end
