require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup :set_user

  test "should be valid" do
    assert @user.valid?
  end

  test "should have an email" do
    @user.email = nil

    assert_not @user.valid?
  end

  test "email should be unique" do
    user = User.new(email: @user.email)
    user.valid?

    assert user.errors[:email].include?("has already been taken")
  end

  test "email should be valid" do
    @user.email = "foo.bar"
    @user.valid?

    assert @user.errors[:email].include?("is not a valid email address")
  end

  test "should have a password" do
    user = User.new
    user.valid?

    assert user.errors[:password].any?
  end

  test "password should be at least 8 characters" do
    @user.password = "hello"
    @user.valid?

    assert @user.errors[:password].include?("is too short (minimum is 8 characters)")
  end

  test "password should contain a number" do
    @user.password = "Letmeinplease"
    @user.valid?

    assert @user.errors[:password].include?("must contain at least 1 lowercase letter, 1 uppercase letter and 1 number")
  end

  test "password should contain a letter" do
    @user.password = "8675309"
    @user.valid?

    assert @user.errors[:password].include?("must contain at least 1 lowercase letter, 1 uppercase letter and 1 number")
  end

  test "password should contain an uppercase letter" do
    @user.password = "1letmein!"
    @user.valid?

    assert @user.errors[:password].include?("must contain at least 1 lowercase letter, 1 uppercase letter and 1 number")
  end

  test "should have a username" do
    @user.username = nil

    assert_not @user.valid?
  end

  test "should generate random username" do
    user = User.new

    assert user.username.present?
  end

  test "should only accept valid time zones" do
    @user.time_zone = "invalid time zone"

    assert_not @user.valid?
  end

  test "should not generate random password by default" do
    user = User.new

    assert user.password.nil?
  end

  test "should generate random password when instructed" do
    user = User.new(generate_random_password: true)
    user.valid?

    assert user.errors[:password].empty?
  end

  test "should generate email verification token" do
    assert @user.generate_token_for(:email_verification).present?
  end

  test "should generate password reset token" do
    assert @user.generate_token_for(:password_reset).present?
  end

  private

  def set_user
    @user = users(:mark)
  end
end
