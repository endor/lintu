ENV['RACK_ENV'] ||= ENV['RAILS_ENV']
require File.join(File.dirname(__FILE__), 'fake-backend.rb')

run FakeBackend.new
