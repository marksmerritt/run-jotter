require "test_helper"

class RunTest < ActiveSupport::TestCase
  setup :set_run

  test "should be valid" do
    assert @run.valid?
  end

  test "converts distance from kilometers to meters" do
    @run.distance_display_unit = "kilometers"
    @run.distance = 5

    @run.valid?

    assert_equal 5000, @run.distance
  end

  test "converts distance from miles to meters" do
    @run.distance_display_unit = "miles"
    @run.distance = 3

    @run.valid?

    assert_equal 4828.032, @run.distance
  end

  test "converts distance from yards to meters" do
    @run.distance_display_unit = "yards"
    @run.distance = 880

    @run.valid?

    assert_equal 804.672, @run.distance
  end

  test "keeps same distance when meters provided" do
    @run.distance_display_unit = "meters"
    @run.distance = 1600

    @run.valid?

    assert_equal 1600, @run.distance
  end

  test "converts elevation from feet to meters" do
    @run.elevation_display_unit = "feet"
    @run.elevation = 10000

    @run.valid?

    assert_equal 3048, @run.elevation
  end

  private

  def set_run
    @run = runs(:fartlek)
  end
end
