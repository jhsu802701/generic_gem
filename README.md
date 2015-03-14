# GenericGem

Welcome to GenericGem!  The purpose of this gem is to streamline the process of creating a gem with Bundler.  

## What's the point?
I HATE having to jump through hoops just to take care of the generic details that are necessary for all or most Ruby gems.  Every time I have created a Ruby gem, there were numerous details that I had to remember to do.  The generic aspects of a gem are fully automated so that you have more time available to work on the capabilities that make your Ruby gem unique.

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
* RSpec testing is automatically included and installed.  Your gem will pass the initial meaningless tests.
* The version number is set to 0.0.0.
* The bin/console and bin/setup script files are made executable.
* The gem_test.sh script is added to the gem's root directory.  This is the 1-step test procedure that executes the bin/setup script (which includes the "bundle install" command) AND the command "rake".  Just enter the command "sh gem_test.sh" command to start the process.  It is 
* 

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

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/generic_gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
