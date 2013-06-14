require 'opener/pos_taggers/base'
require 'opener/pos_taggers/en'
require 'opener/pos_taggers/fr'
require 'opener/pos_taggers/es'
require 'opener/pos_taggers/it'
require 'nokogiri'
require 'open3'

require_relative 'pos_tagger/version'
require_relative 'pos_tagger/cli'

module Opener
  ##
  # Primary POS tagger class that delegates work the various POS tagging
  # kernels.
  #
  # @!attribute [r] options
  #  @return [Hash]
  #
  class POSTagger
    attr_reader :options

    ##
    # Hash containing the default options to use.
    #
    # @return [Hash]
    #
    DEFAULT_OPTIONS = {
      :args => []
    }.freeze

    ##
    # @param [Hash] options
    #
    # @option options [Array] :args Arbitrary arguments to pass to the
    #  underlying kernel.
    #
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
    end

    ##
    # Processes the input and returns an Array containing the output of STDOUT,
    # STDERR and an object containing process information.
    #
    # @param [String] input The input to process.
    # @return [Array]
    #
    def run(input)
      language = language_from_kaf(input)

      unless valid_language?(language)
        raise ArgumentError, "The specified language (#{language}) is invalid"
      end

      kernel = language_constant(language).new(:args => options[:args])

      return Open3.capture3(kernel.command, :stdin_data => input)
    end

    alias tag run

    protected

    ##
    # Extracts the language from a KAF document.
    #
    # @param [String] input
    # @return [String]
    #
    def language_from_kaf(input)
      reader = Nokogiri::XML::Reader(input)

      return reader.read.lang
    end

    ##
    # @param [String] language
    # @return [Class]
    #
    def language_constant(language)
      Opener::POSTaggers.const_get(language.upcase)
    end

    ##
    # @return [TrueClass|FalseClass]
    #
    def valid_language?(language)
      return Opener::POSTaggers.const_defined?(language.upcase)
    end
  end # POSTagger
end # Opener
