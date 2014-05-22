#!/usr/bin/env ruby

require 'opener/daemons'
require_relative '../lib/opener/pos_tagger'

options = Opener::Daemons::OptParser.parse!(ARGV)
daemon  = Opener::Daemons::Daemon.new(Opener::PosTagger, options)

daemon.start