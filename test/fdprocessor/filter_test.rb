#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'fdprocessor/filter'
require 'pathname'

module FDProcessor
  class TestCase < Test::Unit::TestCase
    def assert_basename_filter expect_match, pattern, filename
      bnf = BaseNameFilter.new pattern
      pn = Pathname.new filename
      assert_equal expect_match, !bnf.match?(pn).nil?, "expect_match: #{expect_match}; pattern: #{pattern}; filename: #{filename}"
    end

    def test_basenamefilter_match
      assert_basename_filter true, 'foo', '/tmp/foo.txt'
    end

    def test_basenamefilter_nomatch_full_basename
      assert_basename_filter false, 'foo', '/tmp/bar.txt'
    end

    def test_basenamefilter_nomatch_start_basename
      assert_basename_filter false, 'foo', '/tmp/foobar.txt'
    end

    def test_basenamefilter_match_regexp
      assert_basename_filter true, %r{foo}, '/tmp/foo.txt'
    end

    def test_basenamefilter_match_regexp_start
      assert_basename_filter true, %r{foo}, '/tmp/foobar.txt'
    end

    def test_basenamefilter_nomatch_regexp
      assert_basename_filter false, %r{foo}, '/tmp/bar.txt'
    end
  end
end
