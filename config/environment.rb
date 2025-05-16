require 'bundler/setup'

Bundler.require

# load environment variables
require 'dotenv'
Dotenv.load

# Set environment
ENV['RACK_ENV'] ||= 'development'

# DB config
set :database_file, "config/database.yml"

# load app structure
Dir[File.expand_path('../*.rb', __FILE__)].each { |f| require f }
# auto load all helper files
Dir[File.join(__dir__, 'helpers', '*.rb')].each { |file| require_relative file }
