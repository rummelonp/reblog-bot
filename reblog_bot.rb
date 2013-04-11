#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

root = File.dirname(__FILE__)
$:.unshift File.join(root, 'lib')

require 'reblog_bot'

ReblogBot::Tasks::Cli.start
