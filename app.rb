require 'sinatra'
require 'sinatra/reloader' if development?
require_relative './config/environment'
require_relative './helpers/response_helper'

class App < Sinatra::Base
  
end


# users = {
#   'thibault': { first_name: 'Tibo', last_name: 'Denizet', age: 25 },
#   'simon':    { first_name: 'Simon', last_name: 'Random', age: 26 },
#   'john':     { first_name: 'John', last_name: 'Smith', age: 28 }
# }

# get '/users' do
#   users.map { |name, data| data.merge(id: name) }.to_json
# end