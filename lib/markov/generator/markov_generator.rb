
module MarkovGenerator
  
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
        puts "#{parts[0]}"
      end
      
    end
    
    private
    
    def next_token
    end
    
  end
  
end


markov = MarkovGenerator::Dictionary.new

markov.parse_source "../../../public/text/test_grimm.txt"
