#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'speaker'

puts ARGV.inspect

Speaker.new(:filename => ARGV[0]).play_all
