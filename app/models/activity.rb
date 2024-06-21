class Activity < ApplicationRecord
  TYPES = %w[ Run Ride Swim Walk Hike ]

  delegated_type :activityable, types: TYPES, dependent: :destroy

  belongs_to :user

  has_rich_text :description

  accepts_nested_attributes_for :activityable

  validates :title, presence: true
end
