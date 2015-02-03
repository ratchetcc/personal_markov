#!/usr/bin/env ruby -i

# A Markov Chain generator.

module MarkovGen
  
  VERSION = '0.1.0'
  
  class Dictionary
    
    attr_reader :dictionary, :start_words, :depth, :sentence_length
    
    def initialize(depth=2,length=30)
      @depth = depth
      @sentence_length = length
      @split_words = /(['.?!\n])|[\s]+/
      @split_sentence = /(?<=[.!?])\s+/
      @dictionary = {}
      @start_words = {}
    end
    
    class FileNotFoundError < Exception # :nodoc:
    end
    
    class EmptyDictionaryError < Exception # :nodoc:
    end
    
    def parse_source(source)
      if File.exists?(source)
        contents = File.open(source, "r").read.split(@split_sentence)
      else
        raise FileNotFoundError.new("#{source} does not exist!")
      end
      
      # remove quotation marks
      contents.map! {|sentence| sentence.gsub(/["()]/,"")}
      
      # add a period if it is missing
      if( !contents.empty? && !['.', '!', '?'].include?( contents[-1].strip[-1] ) )
        contents[-1] = contents[-1].strip + '.'
      end
      
      contents.each do |sentence|
        parts = sentence.split(@split_words).delete_if{ |e| e.length == 0 }
        
        add_to_start_words( parts[0..@depth-1]) unless parts.length <= @depth
        
        parts.each_cons(@depth+1) do |words|
          add_word(words[0..-2], words[-1])
        end
      end
    
    end # parse_source
    
    def generate_sentence(sentencecount)
      if @dictionary.empty?
        raise EmptyDictionaryError.new("The dictionary is empty! Parse a source file/string first!")
      end
      
      sentence = []
           
      sentencecount.times do
        sentence.concat(random_start)
        wordcount = 0
        
        until (punctuation?(sentence.last[-1])) || wordcount > @sentence_length
          
          wordcount += 1
          word = weighted_random(sentence.last(@depth))
          
          if punctuation?(word)
            sentence[-1] = sentence.last.dup << word
          else
            sentence << word
          end
        end
          
      end
      
      sentence.join(' ')
      
    end # generate_sentence
    
    private
    
    def add_word(rootword, followedby)
      @dictionary[rootword] ||= []
      @dictionary[rootword] << followedby
    end
    
    def add_to_start_words(words)
      @start_words[words] ||= 0
      @start_words[words] = @start_words[words] + 1
    end
    
    def random_start
      @start_words.keys[rand(@start_words.keys.length)]
    end
    
    def punctuation?(word)
      ( word =~ /[!?]/ || word == '.' )
    end
    
    def weighted_random(last)
      words = @dictionary[last]
      if words == nil
        "."
      else
        words[rand(words.length-1)]
      end 
    end
    
  end
  
end

