# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

require 'dotenv'
Dotenv.load

ENV['RACK_ENV'] ||= 'development'

require './config/environment'

# Load app files
Dir[File.join(__dir__, 'helpers', '*.rb')].each { |f| require f }
Dir[File.join(__dir__, 'controllers', '*.rb')].each { |f| require f }

require './app'

run App
