[![Gem Version](https://badge.fury.io/rb/generic_gem.svg)](https://badge.fury.io/rb/generic_gem)
[![Dependency Status](https://gemnasium.com/jhsu802701/generic_gem.svg)](https://gemnasium.com/jhsu802701/generic_gem)
[![Build Status](https://travis-ci.org/jhsu802701/generic_gem.svg?branch=master)](https://travis-ci.org/jhsu802701/generic_gem)
[![Code Climate](https://codeclimate.com/github/jhsu802701/generic_gem/badges/gpa.svg)](https://codeclimate.com/github/jhsu802701/generic_gem)
[![Test Coverage](https://codeclimate.com/github/jhsu802701/generic_gem/badges/coverage.svg)](https://codeclimate.com/github/jhsu802701/generic_gem/coverage)

# GenericGem

Welcome to GenericGem!  The purpose of this gem is to streamline the process of creating a gem with Bundler.  

## What's the point?
I HATE having to jump through hoops just to take care of the generic details that are necessary for all or most Ruby gems.  Every time I have created a Ruby gem, there were numerous details that I had to remember to do.  The generic aspects of a gem are fully automated to minimize the drudgery so that you have more time available to work on the capabilities that make your Ruby gem unique.

## Prerequisites for Understanding GenericGem
You should be familiar with the process of building a Ruby gem.  Some good resources are:

    https://quickleft.com/blog/engineering-lunch-series-step-by-step-guide-to-building-your-first-ruby-gem/
    http://rakeroutes.com/blog/lets-write-a-gem-part-one/
    http://rakeroutes.com/blog/lets-write-a-gem-part-two/
    http://guides.rubygems.org/make-your-own-gem/
    
## How does GenericGem work?
GenericGem uses the bundle command to begin the process of creating a gem.  Additionally, it adds a number of enhancements needed by all or most Ruby gems.  These changes are:

* The Code of Conduct and MIT license are automatically included.  (It's easier to remove them than to remember to add them.)
* Your name is automatically filled in the file LICENSE.txt and in the gemspec file.
* The gem description in the gemspec file is "GENERIC DESCRIPTION" to enable the "rake install" command.
* The gem summary in the gemspec file is "GENERIC SUMMARY" to enable the "rake install" command.
* Your email address is automatically provided in the gemspec file.
* RSpec testing is automatically included and installed.  Your gem will pass the initial meaningless tests.
* The version number is set to 0.0.0.
* The bin/console and bin/setup script files are made executable.
* A working Rakefile is provided.
* The gem_test.sh script is added to the gem's root directory.  This is the 1-step test procedure that executes the bin/setup script (which includes the "bundle install" command) AND the command "rake".  Just enter the command "sh gem_test.sh" command to start the process.  When you clone your gem's source code onto a machine with a fresh Ruby on Rails installation, running the gem_test.sh script should confirm that all of the details needed to make your gem work are complete.
* The .gitignore file includes .DS_Store and the directories tmp and tmp*.
* Instructions on using the gem_test.sh and gem_console.sh scripts are included in the README.md file.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'generic_gem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install generic_gem

## Usage

Just enter the command "generic_gem".  When prompted, provide the name of your new gem, your name, and your email address.  Your new gem will be automatically created AND tested.  The initial meaningless tests will pass.

## Development

### Testing this gem

After cloning this source code, cd your way into this directory and enter the command `sh gem_test.sh`.  Note that this script also runs the code_test.sh and gem_install.sh scripts.

### Testing this gem's source code
Enter the command `sh code_test.sh` to test the quality of the source code.

### Running this gem in irb
Enter the command `sh gem_console.sh`.

### Installing this gem

Enter the command `sh gem_install.sh`.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/generic_gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
