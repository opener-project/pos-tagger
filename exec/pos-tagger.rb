#!/usr/bin/env ruby

require 'opener/daemons'

require_relative '../lib/opener/pos_tagger'

daemon = Opener::Daemons::Daemon.new(Opener::POSTagger)

daemon.start
