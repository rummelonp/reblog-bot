# -*- coding: utf-8 -*-

$:.unshift File.expand_path 'lib'

require 'rubygems'
require 'bundler'
Bundler.require
require 'reblog_bot'

ReblogBot::Cli.start
