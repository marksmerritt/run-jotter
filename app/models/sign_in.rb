class SignIn < ApplicationRecord
  include UserAgentParseable

  belongs_to :user
end
