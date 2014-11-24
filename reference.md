## Reference

### Command Line Interface

#### Examples:

##### Provide subexamples

    cat english.kaf | pos-tagger

Will result in:


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


### Webservice

You can launch a webservice by executing:

    pos-tagger-server

After launching the server, you can reach the webservice at
<http://localhost:9292>.

The webservice takes several options that get passed along to
[Puma](http://puma.io), the webserver used by the component. The options are:

    -h, --help                Shows this help message
        --puma-help           Shows the options of Puma
    -b, --bucket              The S3 bucket to store output in
        --authentication      An authentication endpoint to use
        --secret              Parameter name for the authentication secret
        --token               Parameter name for the authentication token
        --disable-syslog      Disables Syslog logging (enabled by default)

### Daemon

The daemon has the default OpeNER daemon options. Being:

    Usage: pos-tagger-daemon <start|stop|restart> [options]

When calling pos-tagger without `<start|stop|restart>` the daemon will start as
a foreground process.

Daemon options:

    -h, --help                Shows this help message
    -i, --input               The name of the input queue (default: opener-pos-tagger)
    -b, --bucket              The S3 bucket to store output in (default: opener-pos-tagger)
    -P, --pidfile             Path to the PID file (default: /var/run/opener/opener-pos-tagger-daemon.pid)
    -t, --threads             The amount of threads to use (default: 10)
    -w, --wait                The amount of seconds to wait for the daemon to start (default: 3)
        --disable-syslog      Disables Syslog logging (enabled by default)

#### Environment Variables

These daemons make use of Amazon SQS queues and other Amazon services. For these
services to work correctly you'll need to have various environment variables
set. These are as following:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_REGION`

For example:

    AWS_REGION='eu-west-1' language-identifier start [other options]

### Languages

* Dutch (nl)
* English (en)
* French (fr)
* German (de)
* Italian (it)
* Spanish (es)



