#!/usr/bin/ruby -w
# -*- ruby -*-

require 'minitest/autorun'
require 'fdprocessor/filter'
require 'pathname'

module FDProcessor
  module FilterTest
    def assert_filter_match expect_match, filtercls, pattern, filename
      bnf = filtercls.new pattern
      pn = Pathname.new filename
      msg = "expect_match: #{expect_match}; filtercls: #{filtercls}; pattern: #{pattern}; filename: #{filename}"
      assert_equal expect_match, !!bnf.match?(pn), msg
    end
  end

  class BaseNameFilterTestCase < Minitest::Test
    include FilterTest
    
    def assert_match expect_match, pattern, filename
      assert_filter_match expect_match, BaseNameFilter, pattern, filename
    end

    def test_match
      assert_match true, 'foo.txt', '/tmp/foo.txt'
    end

    def test_nomatch_full
      assert_match false, 'foo.txt', '/tmp/bar.txt'
    end

    def test_nomatch_start
      assert_match false, 'foo', '/tmp/foobar.txt'
    end

    def test_nomatch_end
      assert_match false, 'foo.txt', '/tmp/barfoo.txt'
    end

    def test_match_regexp
      assert_match true, %r{foo}, '/tmp/foo.txt'
    end

    def test_match_regexp_start
      assert_match true, %r{foo}, '/tmp/foobar.txt'
    end

    def test_nomatch_regexp
      assert_match false, %r{foo}, '/tmp/bar.txt'
    end
  end

  class ExtFilterTestCase < Minitest::Test
    include FilterTest

    def assert_match expect_match, pattern, filename
      assert_filter_match expect_match, ExtFilter, pattern, filename
    end

    def test_match
      assert_match true, '.txt', '/tmp/foo.txt'
    end

    def test_nomatch_full
      assert_match false, '.txt', '/tmp/foo.lst'
    end

    def test_nomatch_start
      assert_match false, '.txt', '/tmp/foo.2txt'
    end

    def test_nomatch_end
      assert_match false, '.txt', '/tmp/foo.txt2'
    end

    def test_match_regexp
      assert_match true, %r{\.te?xt}, '/tmp/foo.txt'
    end

    def test_match_regexp_start
      assert_match true, %r{\.te?xt}, '/tmp/foo.txt2'
    end

    def test_nomatch_regexp
      assert_match false, %r{\.te?xt}, '/tmp/bar.lst'
    end
  end
end
