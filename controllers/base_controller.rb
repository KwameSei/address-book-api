require 'sinatra/base'
require_relative '.././config/environment'

class BaseController < Sinatra::Base
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
end