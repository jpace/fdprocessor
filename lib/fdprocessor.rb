#!/usr/bin/ruby -w
# -*- ruby -*-

require 'fdprocessor/filter'
require 'pathname'

module FDProcessor
  VERSION = '1.0.0'

  # A base class for processing files and directories.
  class Processor
    def initialize(*args)
      args = args.flatten
      if args[-1].kind_of? Filter
        @filter = args.pop
      else
        @filter = nil
      end
      
      args.each do |arg|
        process Pathname.new arg
      end
    end

    def process_file file
    end

    def process_directory dir
      dir.children.sort.each do |fd|
        process fd
      end
    end

    def process fd
      if fd.directory?
        process_directory fd
      elsif fd.file?
        return if filtered? fd, @filter
        process_file fd
      else
        process_unknown_type fd
      end
    end

    def process_unknown_type fd
    end

    private
    def filtered? fd, filter
      filter && !filter.match?(fd)
    end
  end
end
