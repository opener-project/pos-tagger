require_relative "pos_tagger/version"
require "opener/pos_taggers/base"
require "opener/pos_taggers/en"
require "opener/pos_taggers/fr"
require "opener/pos_taggers/es"
require "opener/pos_taggers/it"
require "nokogiri"
require "open3"

module Opener
  class POSTagger
    attr_reader :args
    attr_accessor :options
        
    def tag(text)
      language = get_kaf_language(text)      
      pos_tagger = pos_tagger_for_language(language)
      output, error, process = Open3.capture3(pos_tagger.command, :stdin_data=>text)
    end
    
    alias :run :tag
    
    protected

    def pos_tagger_for_language(language)
      Opener::POSTaggers.const_get(language.upcase).new
    end
    
    def get_kaf_language(text)
      reader = Nokogiri::XML::Reader(text)
      language = reader.read.lang
      check_language_support(language)
      return language
    end
    
    def check_language_support(language)
      abort "'#{language}' language is not supported." if !language_list.include?(language.downcase)
    end
      
    def language_list
      ['en', 'fr', 'es', 'it', 'de', 'nl']
    end
  end
end
