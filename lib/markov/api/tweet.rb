
require 'json'
require 'markov/generator/markov_gen'

module Markov
  
  class Tweet < Endpoint
      
    @@markov = nil 
    
    configure do
      @@markov = MarkovGen::Dictionary.new 3, 26
      
      #Dir["public/text/en_*"].each do | f |
      #  puts "*** Analyzing '#{f}' "
      #  @@markov.parse_source f
      #end
      
      # just some texts for now
      #@@markov.parse_source "public/text/en_bible.txt"
      @@markov.parse_source "public/text/en_cthulhu.txt"
      
    end
      
    get "/v#{Markov::API_VERSION}/markov" do
      http_status = 200
      resp = {}
      
      begin
        sentences = @@markov.generate_sentence 4
        
        resp = {
          :text => sentences
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
    
    get "/markov" do
      @sentences = @@markov.generate_sentence 4
      erb :markov
    end
    
  end # class Markov 
  
end # module Markov