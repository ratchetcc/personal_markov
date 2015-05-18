
require 'markov/generator'

module Markov
  
  class Main < Sinatra::Application
      
    @@markov = nil 
    
    configure do
      @@markov = Markov::Generator.new 3
      
      Dir["public/text/en_*"].each do | f |
        puts "*** Analyzing '#{f}' "
        @@markov.parse_source_file f
      end
      
    end
          
    get "/" do
      @sentences = @@markov.generate_sentence 60
      erb :markov
    end
    
  end # class Markov 
  
end # module Markov