POS-tagger
------------

Component that wraps the different existing POS Taggers.

### Confused by some terminology?

This software is part of a larger collection of natural language processing
tools known as "the OpeNER project". You can find more information about the
project at (the OpeNER portal)[http://opener-project.github.io]. There you can
also find references to terms like KAF (an XML standard to represent linguistic
annotations in texts), component, cores, scenario's and pipelines.

Quick Use Example
-----------------

Installing the pos-tagger can be done by executing:

    gem install opener-pos-tagger

Please bare in mind that all components in OpeNER take KAF as an input and
output KAF by default.

### Command line interface

You should now be able to call the POS tagger as a regular shell
command: by its name. Once installed the gem normalyl sits in your path so you can call it directly from anywhere.

This aplication reads a text from standard input in order to identify the language.

POS Tagging some text (assuming that the above text is in a file called *english.kaf*):

    cat english.kaf | pos-tagger
    
Will result in

    <?xml version='1.0' encoding='UTF-8'?>
    <KAF version="v1.opener" xml:lang="en">
      <kafHeader>
        <linguisticProcessors layer="text">
          <lp name="opennlp-en-tok" timestamp="2013-06-11T13:41:37Z" version="1.0"/>
          <lp name="opennlp-en-sent" timestamp="2013-06-11T13:41:37Z" version="1.0"/>
        </linguisticProcessors>
        <linguisticProcessor layer="term">
          <lp timestamp="2013-06-12T15:18:03CEST" version="1.0" name="Open nlp pos tagger"/>
        </linguisticProcessor>
      </kafHeader>
      <text>
        <wf length="4" offset="0" para="1" sent="1" wid="w1">this</wf>
        <wf length="2" offset="5" para="1" sent="1" wid="w2">is</wf>
        <wf length="2" offset="8" para="1" sent="1" wid="w3">an</wf>
        <wf length="7" offset="11" para="1" sent="1" wid="w4">english</wf>
        <wf length="4" offset="19" para="1" sent="1" wid="w5">text</wf>
      </text>
      <terms>
        <term lemma="this" morphofeat="FM" pos="O" tid="t_1" type="open">
          <span>
            <target id="w1"/>
          </span>
        </term>
        <term lemma="is" morphofeat="FM" pos="O" tid="t_2" type="open">
          <span>
            <target id="w2"/>
          </span>
        </term>
        <term lemma="an" morphofeat="APPR" pos="P" tid="t_3" type="close">
          <span>
            <target id="w3"/>
          </span>
        </term>
        <term lemma="english" morphofeat="FM" pos="O" tid="t_4" type="open">
          <span>
            <target id="w4"/>
          </span>
        </term>
        <term lemma="text" morphofeat="FM" pos="O" tid="t_5" type="open">
          <span>
            <target id="w5"/>
          </span>
        </term>
      </terms>
    </KAF>

### Webservices

You can launch a language identification webservice by executing:

    pos-tagger-server

This will launch a mini webserver with the webservice. It defaults to port 9292,
so you can access it at <http://localhost:9292>.

To launch it on a different port provide the `-p [port-number]` option like
this:

    pos-tagger-server -p 1234

It then launches at <http://localhost:1234>

Documentation on the Webservice is provided by surfing to the urls provided
above. For more information on how to launch a webservice run the command with
the ```-h``` option.


### Daemon

Last but not least the POS tagger comes shipped with a daemon that
can read jobs (and write) jobs to and from Amazon SQS queues. For more
information type:

    pos-tagger-daemon -h

Description of dependencies
---------------------------

This component runs best if you run it in an environment suited for OpeNER
components. You can find an installation guide and helper tools in the (OpeNER
installer)[https://github.com/opener-project/opener-installer] and (an
installation guide on the Opener
Website)[http://opener-project.github.io/getting-started/how-to/local-installation.html]

At least you need the following system setup:

### Depenencies for normal use:

* JRuby (1.7.9+)
* Java 1.7 or newer (There are problems with encoding in older versions).

### Dependencies if you want to modify the component:

* Maven (for building the Gem)

Language Extension
------------------

  TODO

The Core
--------

The component is a fat wrapper around the actual language technology core. You
can find the core technolies in the following repositories: (https://github.com/opener-project/?query=pos)[https://github.com/opener-project/?query=pos]

Where to go from here
---------------------

* Check (the project websitere)[http://opener-project.github.io]
* (Checkout the webservice)[http://opener.olery.com/pos-tagger]

Report problem/Get help
-----------------------

If you encounter problems, please email support@opener-project.eu or leave an
issue in the (issue tracker)[https://github.com/opener-project/pos-tagger/issues].


Contributing
------------

1. Fork it ( http://github.com/opener-project/pos-tagger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
