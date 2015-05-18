
module Markov
  
  class Token < Struct.new(:word, :kind)
    # used as an internal structure to hold words etc
  end
  
  class Generator
    
    attr_reader :depth
    
    def initialize(depth=3)
      @depth = depth
      @split_words = /([',.?!\n])|[\s]+/
      @split_sentence = /(?<=[.!?\n])\s+/
      @dictionary = {}
      @start_words = {}
      @unparsed_sentences = []
      @tokens = []
    end
    
    class FileNotFoundError < Exception # :nodoc:
    end
    
    class EmptyDictionaryError < Exception # :nodoc:
    end
    
    def parse_string(sentence)
      add_unparsed_sentence sentence
      parse_text
    end
    
    def parse_source_file(source)
      
      if File.exists?(source)
        sentences = File.open(source, "r").read.split(@split_sentence)
      else
        raise FileNotFoundError.new("#{source} does not exist!")
      end
      
      sentences.each do |sentence|
        add_unparsed_sentence sentence
      end
      
      parse_text
      
    end
    
    def generate_sentence(wordcount=30)
      if @dictionary.empty?
        raise EmptyDictionaryError.new("The dictionary is empty! Parse a source file/string first!")
      end
      
      sentence = []
      select_start_words.each {|w| sentence << w}
      
      complete_sentence = false
      i = 1
      
      prev_token = select_next_word sentence.last(@depth-1)
      begin
        token = select_next_word sentence.last(@depth-1)
        if prev_token.kind == :special && token.kind == :stop
          begin
            token = select_next_word sentence.last(@depth-1)
          end until token.kind == :word
        end
        
        if token.kind == :word
          sentence << token.word
        else
          sentence << token.word
          if (token.kind == :stop && i < wordcount)
            select_start_words.each {|w| sentence << w}
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
    
    def parse_text
            
      state = :start # :start, :word, :special, :stop
      word_seq = []
      
      begin
        while token = next_token
          
          if state == :start
            word_seq << token
            
            # fill the array
            (@depth-word_seq.size).times do
              word_seq << next_token
            end
            
            # need to store the words in both the dictionary 
            # and the list of start words
            add_to_start_words word_seq[0, @depth-1]
            add_to_dictionary word_seq
            
            token = next_token
            state = :sentence
          end
          
          if state == :sentence
            # move the array one position
            word_seq.slice!(0)
            word_seq << token
            
            # add to the dictionary
            add_to_dictionary word_seq
            
            # stop current sequence and start again
            if token.kind == :stop
              word_seq = []
              state = :start
            end  
          end
          
        end # end while
        
      rescue
        # nothing to rescue
      end
      
    end # end parse_text
    
    def next_token
      if @tokens.empty?
        sentence = @unparsed_sentences.slice!(0)
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
    
    def add_unparsed_sentence(sentence)
      # replace unwanted characterts
      sentence.gsub(/["()]/,"")
      sentence.gsub(/[„()]/,"")
      sentence.gsub(/['()]/,"")
      sentence.gsub(/[“()]/,"")
      
      parts = sentence.split(@split_words)
      if parts && !parts.empty?
        @unparsed_sentences << parts
      end
      
    end
    
    def add_to_start_words(tokens)
      return if tokens[0].kind != :word
      
      tokens[0].word = tokens[0].word.capitalize
      words = tokens_to_words tokens
      
      @start_words[words] ||= 0
      @start_words[words] = @start_words[words] + 1
      
    end
    
    def add_to_dictionary(tokens)
      key_words = tokens_to_words tokens[0, @depth-1]     
      token = tokens.last
      
      @dictionary[key_words] ||= []
      @dictionary[key_words] << token
    end
    
    def tokens_to_words(tokens)
      words = []
      tokens.each do |t|
        words << t.word
      end
      words
    end

    def select_start_words
      @start_words.keys[rand(@start_words.keys.length)]
    end
    
    def select_next_word(prev_words)
      tokens = @dictionary[prev_words]
      
      return Token.new("X", :stop) if tokens == nil  
      tokens[rand(tokens.length-1)]
    end
    
  end
  
end


#markov = MarkovGenerator::Dictionary.new

#markov.parse_source_file "../../../public/text/de_grimm.txt"
#markov.parse_source_file "../../../public/text/de_poe.txt"

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
