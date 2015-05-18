
require 'markov/generator'

module Markov
  
  class Main < Sinatra::Application
      
    @@markov = nil 
    
    configure do
      @@markov = Markov::Generator.new
      
      Dir["public/text/seed_*"].each do | f |
        puts "*** Analyzing '#{f}' "
        @@markov.parse_source_file f
      end
      
    end
          
    get "/" do
      @sentences = @@markov.generate_sentence 32
      erb :markov
    end
    
  end # class Markov 
  
end # module Markov