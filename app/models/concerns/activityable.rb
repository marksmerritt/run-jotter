module Activityable
  extend ActiveSupport::Concern

  included do
    has_one :activity, as: :activityable, touch: true, dependent: :destroy
  end
end
