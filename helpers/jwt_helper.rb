# require 'jwt'
# require 'dotenv'

# Dotenv.load

# module JwtHelper
#   def jwt_token(user)
#     payload = { user_id: user.id, exp: Time.now.to_i + 3600 } # 1-hour expiry
#     JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
#   end
# end
