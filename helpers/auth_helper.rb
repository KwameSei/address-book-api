require_relative './response_helper'
require 'dotenv'

Dotenv.load

module AuthHelper
  def authenticate!
    token = request.env["HTTP_AUTHORIZATION"]&.split("Bearer ")&.last
    return halt json_response(http_status: 401, custom_status: :unauthorized_route_access) unless token
  
    payload = decode_token(token) rescue nil
    return halt json_response(http_status: 401, custom_status: :token_invalid) unless payload
  
    @current_user = User.find_by(id: payload['user_id'])
    return halt json_response(http_status: 401, custom_status: :user_not_found) unless @current_user
  end

  def decode_token(token)
    JWT.decode(token, ENV['JWT_SECRET'], true, { algorithm: 'HS256' }).first
  end

  def current_user
    @current_user
  end
  
end

# module AuthHelper
#   def authenticate!
#     token = request.env['HTTP_AUTHORIZATION']
#     json_response(http_status: 204, custom_status: :unauthorized_route_access) unless token == ENV['JWT_SECRET']
#   end

#   def current_user
#     token = request.env['HTTP_AUTHORIZATION']&.split(' ')&.last
#     decoded = JWT.decode(token, ENV['JWT_SECRET'], true, { algorithm: 'HS256' }) rescue nil
#     User.find(decoded[0]['user_id']) if decoded
#   rescue
#     nil
#   end
# end