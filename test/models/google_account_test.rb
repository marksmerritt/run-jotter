require "test_helper"

class GoogleAccountTest < ActiveSupport::TestCase
  setup :set_google_account

  test "should be valid" do
    assert @google_account.valid?
  end

  test "should have a google account id" do
    @google_account.google_account_id = nil

    assert_not @google_account.valid?
  end

  test "should have an email" do
    @google_account.email = nil

    assert_not @google_account.valid?
  end

  test "should belong to a user" do
    @google_account.user = nil

    assert_not @google_account.valid?
  end

  private

  def set_google_account
    @google_account = google_accounts(:marks_google_account)
  end
end
