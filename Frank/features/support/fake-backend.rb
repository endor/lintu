require 'rubygems'
require 'sinatra'
require 'json'

ROOT = File.dirname(__FILE__) + '/..'

module Rack
  class CommonLogger
    def call(env)
      # do nothing
      @app.call(env)
    end
  end
end

class FakeBackend < Sinatra::Base
  helpers do
    def log_request(json)
      file = ROOT + "/support/last_requests.log"
      requests = JSON.parse(File.read(file)) rescue []
      File.open(file, "w") do |f|
        f << (requests << json).to_json
      end
    end
  end

  post '/transmission/rpc' do
    json = JSON.parse(request.body.read)

    log_request(json)

    content_type :json
    file = ROOT + "/fixtures/#{json["method"]}.json"
    if(File.exists?(file))
      File.read(file)
    else
      throw(:halt, [404, "Not found\n"])
    end
  end
end