
require 'json'
require 'excon'
require 'mindcast/exceptions'

module Mindcast
  
  class Endpoint < Sinatra::Application
    
    configure do
      #set :etcd_url, lambda { ENV['ETCD_URL'] || "http://127.0.0.1:4001" }
    end
    
    def authorize! (request)
      puts "authorizing: #{request.env}"
      #raise Majordomus::AuthorizationError, "404,FOO!"
    end
    
    def exception_result_status (e)
      500
    end
    
    def exception_result(e)
      {
        'error' => e.message.split(',')[1]
      }
    end
    
  end # Endpoint
  
end # Mindcast

