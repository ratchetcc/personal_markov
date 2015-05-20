
require 'markov/generator'

unless ( File.basename($0) == 'rake')
  markov = Markov::Generator.new
  
  Dir["public/seeds/*.txt"].each do | f |
    puts "*** Analyzing '#{f}' "
    markov.parse_source_file f
  end
  
  Rails.application.config.markov_generator = markov
end