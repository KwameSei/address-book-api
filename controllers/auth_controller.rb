require 'dotenv'
require_relative '../config/environment'

Dotenv.load

class AuthController
  include ResponseHelper

  def register(request)
    data = JSON.parse(request.body.read) rescue {}

    puts "UserValidator is: #{UserValidator.inspect}"

    validator = UserValidator.new(data)

    unless validator.valid?
      return json_response(http_status: 422, custom_status: :invalid_user_data, data: validator.errors)
    end

    user = User.new(name: data['name'], email: data['email'], password: data['password'])

    if user.save
      return json_response(http_status: 200, custom_status: :registration_success, data: { user: user })
    else
      return json_response(http_status: 204, custom_status: :invalid_contact_data, data: user.error.full_messages)
    end
  end

  def login(request)
    data = JSON.parse(request.body.read)
    user = User.find_by(email: data['email'])

    if user && user.authenticate(data['password'])
      token = generate_token(user)
      json_response(http_status: 200, custom_status: :login_success, data: { token: token })
    else
      json_response(http_status: 401, custom_status: :login_failed)
    end
  end

  private

  def generate_token(user)
    payload = { user_id: user.id, exp: Time.now.to_i + 3600 } # 1-hour expiry
    JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
  end
end