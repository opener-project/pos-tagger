module Opener
  class POSTagger
    ##
    # CLI wrapper around {Opener::POSTagger} using Slop.
    #
    # @!attribute [r] parser
    #  @return [Slop]
    #
    class CLI
      attr_reader :parser

      def initialize
        @parser = configure_slop
      end

      ##
      # @param [Array] argv
      #
      def run(argv = ARGV)
        parser.parse(argv)
      end

      ##
      # @return [Slop]
      #
      def configure_slop
        return Slop.new(:strict => false, :indent => 2, :help => true) do
          banner 'Usage: pos-tagger [OPTIONS]'

          separator <<-EOF.chomp

About:

    POS tagger component with support for various languages such as Dutch and
    English. This component reads input from STDIN.

Example:

    cat some_file.kaf | pos-tagger
          EOF

          separator "\nOptions:\n"

          on :v, :version, 'Shows the current version' do
            abort "pos-tagger v#{VERSION} on #{RUBY_DESCRIPTION}"
          end

          run do |opts, args|
            tagger = POSTagger.new(:args => args)
            input  = STDIN.tty? ? nil : STDIN.read

            puts tagger.run(input)
          end
        end
      end
    end # CLI
  end # POSTagger
end # Opener
