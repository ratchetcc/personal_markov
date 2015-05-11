
require 'json'

module Mindcast
  
  class Status < Endpoint
     
    # just return a simple ACK that the server is alive
    get '/status' do
      http_status = 200
      resp = {}
      
      begin
        # do something
        resp = {
          :version => Mindcast::VERSION,
          :codename => Mindcast::CODENAME,
          :status => "OK"
        }
      
      rescue => e
        http_status = exception_result_status e
        resp = exception_result e
      end
      
      # return to consumer
      content_type :json
      status http_status
      resp.to_json
      
    end
    
    get '/debug' do
      content_type :json
      status 200
      
      puts "ENV=#{request.env}"
      
      {
        :status => "OK"
      }.to_json
      
    end
    
    post '/debug' do
      content_type :json
      status 200
      
      puts "ENV=#{request.env}"
      request.body.rewind
      puts "BODY=#{request.body.read}"
      
      {
        :status => "OK"
      }.to_json
      
    end
    
  end # class Status
  
end # module Routes