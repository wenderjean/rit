#!/usr/bin/env ruby

command, *args = ARGV

if command.nil?
  $stderr.puts "Usage: rit <command> [<args>]"
  exit 1
end

path_to_command = File.expand_path("../#{command}.rb", __FILE__)
if !File.exist? path_to_command
  $stderr.puts "Command <#{command}> not found."
  exit 1
end

exec path_to_command, *args
