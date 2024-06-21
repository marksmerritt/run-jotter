require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  setup :set_activity

  test "should be valid" do
    assert @activity.valid?
  end

  test "should have a title" do
    @activity.title = nil

    assert_not @activity.valid?
  end

  test "should have an activityable" do
    @activity.activityable = nil

    assert_not @activity.valid?
  end

  private

  def set_activity
    @activity = activities(:fartlek)
  end
end
