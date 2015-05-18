
require 'markov/generator'

module Markov
  
  class Main < Sinatra::Application
      
    @@markov = nil 
    
    configure do
      @@markov = Markov::Generator.new 3
      
      #Dir["public/text/en_*"].each do | f |
      #  puts "*** Analyzing '#{f}' "
      #  @@markov.parse_source_file f
      #end
      
      # just some texts for now
      @@markov.parse_source_file "public/text/en_cthulhu.txt"
      
    end
          
    get "/" do
      @sentences = @@markov.generate_sentence 60
      erb :markov
    end
    
  end # class Markov 
  
end # module Markov