#!/usr/bin/ruby -w
# -*- ruby -*-

module FDProcessor
  VERSION = '1.0.0'

  # File and directory processor, with filtering.
  class FilterSet
    def initialize args
      @dirsonly = args[:dirsonly]
      @filesonly = args[:filesonly]
      @basename = args[:basename]
      @dirname = args[:dirname]
      @extname = args[:extname]
    end

    def match? fd
      if @dirsonly && !fd.directory?
        false
      elsif @filesonly && !fd.file?
        false
      elsif @basename && @basename != fd.basename.to_s
        false
      elsif @dirname && @dirname != fd.parent.to_s
        false
      elsif @extname && @extname != fd.extname.to_s
        false
      else
        true
      end
    end
  end

  class Processor
    def initialize(*args)
      @filter = nil
      if args[-1].kind_of? Filter
        @filter = args.pop
      end
      args.each do |arg|
        process Pathname.new arg
      end
    end

    def process_file file
    end

    def process_directory dir
      dir.children.sort.each do |fd|
        next if @filter && !@filter.match?(fd)
        process fd
      end
    end

    def process fd
      return if @filter && !@filter.match?(fd)      
      if fd.directory?
        process_directory fd
      elsif fd.file?
        process_file fd
      else
        process_unknown_type fd
      end
    end

    def process_unknown_type fd
    end
  end
end
