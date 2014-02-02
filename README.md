# Cachew

[![Gem Version](https://badge.fury.io/rb/cachew.png)](http://badge.fury.io/rb/cachew)
[![Build Status](https://travis-ci.org/ixti/cachew.png?branch=master)](https://travis-ci.org/ixti/cachew)
[![Coverage Status](https://coveralls.io/repos/ixti/cachew/badge.png?branch=master)](https://coveralls.io/r/ixti/cachew?branch=master)
[![Code Climate](https://codeclimate.com/github/ixti/cachew.png)](https://codeclimate.com/github/ixti/cachew)

Simple (and unified) cache interface.

## Installation

Add this line to your application's Gemfile:

    gem 'cachew'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cachew

## Usage

``` ruby
# With HashAdapter
cache = Cachew.new({})

cache.has?(:foo)           # => false
cache.fetch(:foo) { :bar } # => :bar

cache.has?(:foo)           # => true
cache.fetch(:foo) { :moo } # => :bar


# With (default) NullAdapter
cache = Cachew.new

cache.has?(:foo)           # => false
cache.fetch(:foo) { :bar } # => :bar

cache.has?(:foo)           # => false
cache.fetch(:foo) { :moo } # => :moo
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/cachew/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
