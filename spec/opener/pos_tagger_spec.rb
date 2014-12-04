require 'spec_helper'

describe Opener::POSTagger do
  before do
    @input = <<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<KAF xml:lang="en" version="v1.opener">
  <text>
    <wf wid="w1" sent="1" para="1" offset="0" length="5"><![CDATA[Hello]]></wf>
    <wf wid="w2" sent="1" para="1" offset="6" length="5"><![CDATA[world]]></wf>
  </text>
</KAF>
    EOF

    @invalid_language = <<-EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<KAF xml:lang="bacon" version="v1.opener"></KAF>
    EOF
  end

  context '#run' do
    example 'raise UnsupportedLanguageError for unsupported languages' do
      tagger = described_class.new
      block  = -> { tagger.run(@invalid_language) }

      block.should raise_error(
        Opener::Core::UnsupportedLanguageError,
        /The language "bacon"/
      )
    end

    example 'return a tagged KAF document' do
      output   = described_class.new.run(@input)
      document = Nokogiri::XML(output)

      document.xpath('KAF/terms/term').empty?.should == false
    end
  end

  context '#language_from_kaf' do
    example 'return the language of a KAF document' do
      described_class.new.language_from_kaf(@input).should == 'en'
    end

    example 'return nil if the KAF document did not have a language' do
      input = '<KAF version="v1.opener"></KAF>'

      described_class.new.language_from_kaf(input).should be_nil
    end
  end
end
