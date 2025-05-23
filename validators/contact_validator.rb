require_relative './base_validator'

class ContactValidator < BaseValidator
  def validate
    require("first_name")
    require("last_name")
    require("phone_num")

    min_length("first_name", 3)
    min_length("last_name", 3)
    max_length("first_name", 50)
    max_length("last_name", 50)
    # max_length("phone_num", 10)
    normalize_phone_num_to_local("phone_num")
    valid_ghana_phone("phone_num")
    valid_phone("phone_num") if data["phone_num"]
  end
end