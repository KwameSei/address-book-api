require 'bundler/setup'
# load environment variables
require 'dotenv'
Dotenv.load

Bundler.require

# Set environment
ENV['RACK_ENV'] ||= 'development'

# load database config
set :database_file, "config/database.yml"

# load app structure
Dir[File.expand_path('../*.rb', __FILE__)].each { |f| require f }
# auto load all helper files
Dir[File.join(__dir__, '../helpers/', '*.rb')].each { |file| require_relative file }
# auto load all controller files
Dir[File.join(__dir__, '../controllers/', '*.rb')].each { |file| require_relative file }
# auto load all model files
Dir[File.join(__dir__, '../models/', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, '/config/', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, '../serializers/', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, '../validators/', '*.rb')].each { |file| require_relative file }
