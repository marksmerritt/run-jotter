require "application_system_test_case"

class SignUpsTest < ApplicationSystemTestCase
  test "sign up with all fields completed" do
    visit sign_up_path

    fill_in "sign_up_email_field", with: "test@example.com"
    fill_in "sign_up_password_field", with: "1Letmein!"

    assert_difference "User.count" do
      click_button "sign_up_button"
    end
  end

  test "sign up with unfilled fields" do
    visit sign_up_path

    fill_in "sign_up_email_field", with: "test@example.com"

    assert_no_changes "User.count" do
      click_button "sign_up_button"
    end

    fill_in "sign_up_email_field", with: ""
    fill_in "sign_up_password_field", with: "1Letmein!"

    assert_no_changes "User.count" do
      click_button "sign_up_button"
    end
  end
end
