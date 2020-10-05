require 'open3'

require 'opener/core'
require 'opener/pos_taggers/base'
require 'opener/pos_taggers/en'

require 'nokogiri'
require 'slop'

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
    def run input, params = {}
      language = language_from_kaf(input)

      if !language or !valid_language?(language)
        raise Core::UnsupportedLanguageError, language
      end

      kernel = language_constant(language).new(:args => options[:args])

      return kernel.run(input)
    end

    alias tag run

    ##
    # Extracts the language from a KAF document, returns `nil` if no language
    # was found.
    #
    # @param [String] input
    # @return [String]
    #
    def language_from_kaf(input)
      document = Nokogiri::XML(input)
      language = document.xpath('KAF/@xml:lang')[0]

      return language ? language.to_s : nil
    end

    private

    ##
    # @param [String] language
    # @return [Class]
    #
    def language_constant(language)
      return language && POSTaggers.const_get(language.upcase)
    end

    ##
    # @return [TrueClass|FalseClass]
    #
    def valid_language?(language)
      return Opener::POSTaggers.const_defined?(language.upcase)
    end

  end
end
