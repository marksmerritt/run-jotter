require "application_system_test_case"

class SignInsTest < ApplicationSystemTestCase
  setup :set_user

  test "successful sign in" do
    visit sign_in_path

    fill_in "sign_in_email_field", with: @user.email
    fill_in "sign_in_password_field", with: "1Letmein!"

    assert_difference "SignIn.count" do
      click_button "sign_in_button"
    end

    assert_current_path dashboard_path
  end

  test "sign in with incorrect password" do
    visit sign_in_path

    fill_in "sign_in_email_field", with: @user.email
    fill_in "sign_in_password_field", with: "2Letmein!"

    assert_no_changes "SignIn.count" do
      click_button "sign_in_button"
    end

    assert_current_path sign_in_path
  end

  test "nonexistent user sign in attempt" do
    visit sign_in_path

    fill_in "sign_in_email_field", with: "nonexistent@example.com"
    fill_in "sign_in_password_field", with: "1Letmein!"

    assert_no_changes "SignIn.count" do
      click_button "sign_in_button"
    end

    assert_current_path sign_in_path
  end

  private

  def set_user
    @user = users(:mark)
  end
end
