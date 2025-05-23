require 'sinatra'
require 'sinatra/reloader' if development?
require_relative './config/environment'
require_relative './middleware/logger'

class App < Sinatra::Base
  use RequestLogger

  register Sinatra::ActiveRecordExtension
  helpers Sinatra::JSON
  helpers AuthHelper
  helpers ResponseHelper
  helpers CorsHelper

  before do
    content_type :json
    allow_cors
    authenticate! unless ['/', '/auth/register', '/auth/login'].include?(request.path_info)
  end

  # Preflight response for CORS
  options '*' do
    200
  end
  
  get '/' do
    json message: "Address Book API"
  end

  # Auth routes
  post '/auth/register' do
    AuthController.new.register(request)
  end

  post '/auth/login' do
    AuthController.new.login(request)
  end

  # Contact routes
  contacts_controller = ContactsController.new

  get '/contacts/all-contacts' do
    contacts_controller.index(current_user, params)
  end

  get '/contacts/single-contact/:id' do
    contacts_controller.show(current_user, params[:id])
  end

  post '/contacts/create-contact' do
    contacts_controller.create(current_user, request)
  end

  put '/contacts/update-contact/:id' do
    contacts_controller.update(current_user, params[:id], request)
  end

  delete '/contacts/delete-contact/:id' do
    contacts_controller.destroy(current_user, params[:id])
  end

  # User routes
  users_controller = UsersController.new

  get '/users/all-users' do
    users_controller.index(current_user, params)
  end

  get '/users/single-user/:id' do
    users_controller.show(current_user, params[:id])
  end

  post '/users/create-user' do
    users_controller.create(current_user, request)
  end

  put '/users/update-user/:id' do
    users_controller.update(current_user, params[:id], request)
  end

  delete '/users/delete-user/:id' do
    users_controller.destroy(current_user, params[:id])
  end

  # get '/debug/token' do
  #   json token: ENV['API_TOKEN']
  # end
end