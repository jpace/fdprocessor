#!/usr/bin/ruby -w
# -*- ruby -*-

module FDProcessor
  class Filter
    def match? fd
    end
  end

  # Accepts a regular expression or string as the argument. If the argument is a
  # string, it will be fully matched against the basename; i.e., 'foo' will
  # match 'foo.txt', but not 'foobar.txt'.
  class BaseNameFilter < Filter
    def initialize pattern
      @pattern = pattern.kind_of?(Regexp) ? pattern : Regexp.new('\b' + pattern + '\b')
    end
    
    def match? fd
      fd.basename.to_s.index @pattern
    end
  end
end