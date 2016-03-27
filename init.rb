#!/usr/bin/env ruby

RIT_DIRECTORY=".rit".freeze
OBJECTS_DIRECTORY="#{RIT_DIRECTORY}/objects".freeze
REFS_DIRECTORY="#{RIT_DIRECTORY}/refs".freeze

if Dir.exists? RIT_DIRECTORY
  $stderr.puts "Existing RIT project"
  exit 1
end

def build_objects_directory
  Dir.mkdir OBJECTS_DIRECTORY
  Dir.mkdir "#{OBJECTS_DIRECTORY}/info"
  Dir.mkdir "#{OBJECTS_DIRECTORY}/pack"
end

def build_refs_directory
  Dir.mkdir REFS_DIRECTORY
  Dir.mkdir "#{REFS_DIRECTORY}/heads"
  Dir.mkdir "#{REFS_DIRECTORY}/tags"
end

def initialize_head
  File.open("#{RIT_DIRECTORY}/HEAD", "w") do |file|
    file.puts "refs: refs/head/master"
  end
end

Dir.mkdir RIT_DIRECTORY
build_objects_directory
build_refs_directory
initialize_head

$stdout.puts "RIT initialized in #{RIT_DIRECTORY}"
