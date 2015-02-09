# fdprocessor

Ruby gem for processing files and directories hierarchically.

## Usage

Install the gem:

`gem install fdprocessor`

Use in your code:

```
require 'fdprocessor'

# equivalent to "find -type f"
class FindFiles < FDProcessor
  def process_file file
    puts "file: #{file}"
  end
end

FindFiles.new ARGV
```

## Features

Directories and files are processed hierarchically, in sorted order. FDProcessor
has two methods, `process_directory` and `process_file`, that do as their name
suggests. By default, `process_file` is a no-op, and `process_directory(dir)` calls
process on each file in `dir`. You can hook around `process_directory` as
follows:

```
  def process_directory dir
    puts "starting #{dir}"
    super
    puts "ending #{dir}"
  end
```

Note that `super` must be called by process_directory if you want the subnodes
to be processed.

Conversely, if you want to filter, for example to skip the `.git` directory:

```
  def process_directory dir
    if dir.basename.to_s != '.git'
      super
    end
  end
```

## Author

Jeff Pace (jeugenepace at gmail dot com)

http://www.github.com/jpace/fdprocessor
