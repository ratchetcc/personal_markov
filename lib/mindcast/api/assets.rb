
require 'json'

module Mindcast
  
  class Assets < Endpoint
        
    get "/v#{Mindcast::API_VERSION}/assets" do
      http_status = 200
      resp = {}
      
      begin
        # do something
        p1 = {
        	:title => "Red Tara",
        	:description => "Red Tara",
        	:short_description => "Red Tara",
        	:sku => "E001",
        	:price => "1.99",
        	:categories => ["cat1", "cat2"],
        	:image => "http://dev.getmajordomus.local/wp-content/uploads/2015/03/audio_book_5@2.png"
        }
        
        p2 = {
        	:title => "Sun Tzu of Seattle",
        	:description => "Sun Tzu of Seattle",
        	:short_description => "Sun Tzu of Seattle",
        	:sku => "E002",
        	:price => "2.99",
        	:categories => ["cat2", "cat3"],
        	:image => "http://dev.getmajordomus.local/wp-content/uploads/2015/03/audio_book_4@2.png"
        }
        
        resp = [p1,p2]
        
      rescue => e
        http_status = exception_result_status e
        resp = exception_result e
      end
      
      # return to consumer
      content_type :json
      status http_status
      resp.to_json
      
    end
    
    get "/v#{Mindcast::API_VERSION}/asset/:sku" do
      http_status = 200
      resp = {}
      
      sku = params[:sku]
      
      begin
        # do something
        p1 = {
        	:title => "Red Tara",
        	:description => "Red Tara",
        	:short_description => "Red Tara",
        	:sku => sku,
        	:price => "1.99",
        	:categories => ["cat1", "cat2"],
        	:image => "http://dev.getmajordomus.local/wp-content/uploads/2015/03/audio_book_5@2.png"
        }
        
        resp = p1
        
      rescue => e
        http_status = exception_result_status e
        resp = exception_result e
      end
      
      # return to consumer
      content_type :json
      status http_status
      resp.to_json
      
    end
    
  end # class Assets 
   
end # module Mindcast