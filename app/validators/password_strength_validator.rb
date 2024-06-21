# frozen_string_literal: true

class PasswordStrengthValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/
      record.errors.add(:password, options[:message] || "must contain at least 1 lowercase letter, 1 uppercase letter and 1 number")
    end
  end
end
