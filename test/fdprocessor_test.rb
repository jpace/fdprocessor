#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'fdprocessor'
require 'pathname'

module FDProcessor
  class FDProcessorTestCase < Test::Unit::TestCase
    include FilterTest

    class TestProcessor < Processor
      attr_reader :visited
      
      def initialize(*args)
        @visited = Array.new
        super
      end

      def process_directory dir
        @visited << dir
        super
      end

      def process_file file
        @visited << file
      end
    end
    
    def test_no_filters_include_file
      pn = Pathname.new __FILE__
      rootdir = pn.parent.parent
      fdp = TestProcessor.new rootdir
      assert_includes fdp.visited, pn
    end
    
    def test_no_filters_include_dir
      pn = Pathname.new __FILE__
      rootdir = pn.parent.parent
      fdp = TestProcessor.new rootdir
      assert_includes fdp.visited, rootdir
    end
    
    def test_no_filters_not_included_dir
      pn = Pathname.new __FILE__
      rootdir = pn.parent.parent
      fdp = TestProcessor.new rootdir
      refute_includes fdp.visited, Pathname.new('/tmp')
    end
    
    def test_no_filters_not_included_file
      pn = Pathname.new __FILE__
      rootdir = pn.parent.parent
      fdp = TestProcessor.new rootdir
      refute_includes fdp.visited, Pathname.new('/tmp/foobar')
    end
  end
end
