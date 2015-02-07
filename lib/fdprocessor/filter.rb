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
  class PatternFilter < Filter
    def initialize pattern
      @pattern = pattern
    end
    
    def match? fd
      elmt = match_element fd
      elmtstr = elmt.to_s
      if @pattern.kind_of?(Regexp)
        elmtstr.index @pattern
      else
        elmtstr == @pattern
      end
    end
    
    def match_element fd
    end
  end

  # Matches against the basename of the pathname.
  class BaseNameFilter < PatternFilter
    def match_element fd
      fd.basename
    end
  end

  # Matches against the extersion of the pathname. The pattern should include
  # the dot.
  class ExtFilter < PatternFilter
    def match_element fd
      fd.extname
    end
  end
end
