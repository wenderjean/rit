#!/usr/bin/env ruby

require "digest"
require "zlib"
require "fileutils"

RIT_DIRECTORY = ".rit".freeze
OBJECTS_DIRECTORY = "#{RIT_DIRECTORY}/objects".freeze
INDEX_PATH = "#{RIT_DIRECTORY}/index"

if !Dir.exists? RIT_DIRECTORY
  $stderr.puts "Not an RIT project"
  exit 1
end

path = ARGV.first

if path.nil?
  $stderr.puts "No path specified"
  exit 1
end

file_contents = File.read(path)
sha = Digest::SHA1.hexdigest file_contents
blob = Zlib::Deflate.deflate file_contents
object_directory = "#{OBJECTS_DIRECTORY}/#{sha[0..1]}"
FileUtils.mkdir_p object_directory
blob_path = "#{object_directory}/#{sha[2..-1]}"

File.open(blob_path, "w") do |file|
  file.print(blob)
end

File.open(INDEX_PATH, "a") do |file|
  file.puts("#{sha} #{path}")
end
