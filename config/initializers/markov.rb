
# 
# http://www.gutenberg.org
#

require 'markov_gen'

unless ( File.basename($0) == 'rake')

  puts "*** Initializing the dictionary . . ."

  en_markov = MarkovGen::Dictionary.new 3, 26

  #Dir["public/text/en_*"].each do | f |
  #  puts "*** Analyzing '#{f}' "
  #  en_markov.parse_source f
  #end

  en_markov.parse_source "public/text/en_120_days_of_sodom.txt"
  en_markov.parse_source "public/text/en_1984.txt"
  en_markov.parse_source "public/text/en_brave_new_world.txt"
  en_markov.parse_source "public/text/en_fanny_hill.txt"
  
  Rails.application.config.en_markov = en_markov

  puts "*** DONE."
  
end
