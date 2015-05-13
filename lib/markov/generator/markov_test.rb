#!/usr/bin/env ruby -i

#
# TEST
#
require './markov_gen'

markov = MarkovGen::Dictionary.new

markov.parse_source "../../../public/text/en_cthulhu.txt"
#markov.parse_source "../public/text/en_fanny_hill.txt"

sentences = markov.generate_sentence 5
#puts markov.dictionary
puts "#{sentences}"

#puts markov.dictionary
