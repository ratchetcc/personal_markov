
require 'json'

module Markov
  
  class Tweet < Endpoint
        
    get "/v#{Markov::API_VERSION}/markov" do
      http_status = 200
      resp = {}
      
      begin
        
        resp = {
          :text => "fjkfdj fgjdf fdlgj fdjlg dfjg df"
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
    
  end # class Markov 
   
end # module Markov