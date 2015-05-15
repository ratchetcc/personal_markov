
require 'markov/generator/markov_gen'

module Markov
  
  class Main < Sinatra::Application
      
    @@markov = nil 
    
    configure do
      @@markov = MarkovGen::Dictionary.new 3, 26
      
      Dir["public/text/en_*"].each do | f |
        puts "*** Analyzing '#{f}' "
        @@markov.parse_source f
      end
      
      # just some texts for now
      #@@markov.parse_source "public/text/en_cthulhu.txt"
      
    end
          
    get "/" do
      @sentences = @@markov.generate_sentence 3
      erb :markov
    end
    
  end # class Markov 
  
end # module Markov