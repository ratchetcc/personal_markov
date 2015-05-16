
module Markov
  
  class Token < Struct.new(:word, :kind)
  end
  
  class Generator
    
    attr_reader :dictionary, :start_words, :depth, :sentence_length
    
    def initialize(depth=3,length=30)
      @depth = depth
      @sentence_length = length
      @split_words = /([',.?!\n])|[\s]+/
      @split_sentence = /(?<=[.!?\n])\s+/
      @dictionary = {}
      @start_words = {}
      @sentences = []
      @tokens = []
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
      
      # replace unwanted characterts
      contents.map! {|sentence| sentence.gsub(/["()]/,"")}
      contents.map! {|sentence| sentence.gsub(/[„()]/,"")}
      contents.map! {|sentence| sentence.gsub(/['()]/,"")}
      contents.map! {|sentence| sentence.gsub(/[“()]/,"")}
      
      # add a period if it is missing
      if( !contents.empty? && !['.', '!', '?'].include?( contents[-1].strip[-1] ) )
        contents[-1] = contents[-1].strip + '.'
      end
      
      contents.each do |sentence|
        parts = sentence.split(@split_words).delete_if{ |e| e.length == 0 }
        @sentences << parts
      end
      
      state = :start # :start, :word, :special, :stop, :end
      word_seq = []
      
      begin
        while token = next_token
          
          if state == :start
            word_seq << token
            
            (@depth-word_seq.size).times do
              word_seq << next_token
            end
            
            add_to_start_words word_seq[0, @depth-1]
            add_to_word word_seq
            
            token = next_token
            
            state = :sentence
          end
          
          if state == :sentence
            word_seq.slice!(0)
            word_seq << token
            
            add_to_word word_seq
            
            if token.kind == :stop
              word_seq = []
              state = :start
            end  
          end
          
        end
        
      rescue
        # nothing to rescue
      end
      
    end
    
    def generate_sentence(wordcount=30)
      if @dictionary.empty?
        raise EmptyDictionaryError.new("The dictionary is empty! Parse a source file/string first!")
      end
      
      sentence = []
      random_start.each {|w| sentence << w}
      
      complete_sentence = false
      i = 1
      
      prev_token = weighted_random sentence.last(@depth-1)
      begin
        token = weighted_random sentence.last(@depth-1)
        if prev_token.kind == :special && token.kind == :stop
          begin
            token = weighted_random sentence.last(@depth-1)
          end until token.kind == :word
        end
        
        if token.kind == :word
          sentence << token.word
        else
          sentence << token.word
          if (token.kind == :stop && i < wordcount)
            random_start.each {|w| sentence << w}
          end
        end
        
        i = i + 1
        complete_sentence = true if (i > wordcount and token.kind == :stop)
      end until complete_sentence
      
      s = ""
      sentence.each do |word|
        if [',','.','?','!',':',';'].include? word
          s << word
        else
          s << " " + word
        end
      end
      
      s[1, s.length-1]
      
    end # generate_sentence
    
    private
    
    def next_token
      if @tokens.empty?
        sentence = @sentences.slice!(0)
        if sentence
          sentence.each do |word|
            
            if word.include?("'")
              @tokens << Token.new("'", :special)
            elsif word.include?(",")
              @tokens << Token.new(",", :special)
            elsif word.include?("?")
              @tokens << Token.new("?", :stop)
            elsif word.include?("!")
              @tokens << Token.new("!", :stop)
            elsif word.include?(":")
              @tokens << Token.new(":", :special)
            elsif word.include?(";")
              @tokens << Token.new(";", :special)
            elsif word.include?("-")
              @tokens << Token.new("-", :special)
            elsif word.include?(".")
              @tokens << Token.new(".", :stop)
            elsif word == "\n"
              # skip
            else
              @tokens << Token.new(word, :word)
            end            
          end
        else
          @tokens = nil
        end
      end
      
      return @tokens.slice!(0) if @tokens
      nil  
    end # end next_token
    
    def add_to_start_words(tokens)
      return if tokens[0].kind != :word
      
      tokens[0].word = tokens[0].word.capitalize
      words = tokens_to_words tokens
      
      @start_words[words] ||= 0
      @start_words[words] = @start_words[words] + 1
      
    end
    
    def add_to_word(tokens)
      root = tokens_to_words tokens[0, @depth-1]     
      token = tokens.last
      
      @dictionary[root] ||= []
      @dictionary[root] << token
    end
    
    def tokens_to_words(tokens)
      words = []
      tokens.each do |t|
        words << t.word
      end
      words
    end

    def random_start
      @start_words.keys[rand(@start_words.keys.length)]
    end
    
    def weighted_random(last)
      tokens = @dictionary[last]
      
      #return Token.new("X", :stop) if tokens == nil  
      if tokens == nil
        return Token.new("X", :stop)
      end
      tokens[rand(tokens.length-1)]
    end
    
  end
  
end


#markov = MarkovGenerator::Dictionary.new

#markov.parse_source "../../../public/text/de_grimm.txt"
#markov.parse_source "../../../public/text/de_poe.txt"

#puts "DICT:\n#{markov.dictionary}"
#puts "START:\n#{markov.start_words}"

#puts markov.generate_sentence 25

#d = markov.dictionary
#d.keys.each do |word|
#  tokens = d[word]
#  if tokens.size > 1
#    puts "#{word}(#{tokens.size}) -> #{tokens}"
#  end
#end
