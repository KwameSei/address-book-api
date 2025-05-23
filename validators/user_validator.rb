require_relative './base_validator'

class UserValidator < BaseValidator
  def validate
    require("name")
    require("email")
    require("password")

    min_length("name", 3)
    email_format("email")
    min_length("password", 6)
    max_length("name", 50)
    max_length("password", 30)
    # matches("password", "password_confirmation") if data["password_confirmation"]
  end
end