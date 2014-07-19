# Cachew

[![Gem Version](https://badge.fury.io/rb/cachew.png)](http://badge.fury.io/rb/cachew)
[![Build Status](https://travis-ci.org/ixti/cachew.png?branch=master)](https://travis-ci.org/ixti/cachew)
[![Coverage Status](https://coveralls.io/repos/ixti/cachew/badge.png?branch=master)](https://coveralls.io/r/ixti/cachew?branch=master)
[![Code Climate](https://codeclimate.com/github/ixti/cachew.png)](https://codeclimate.com/github/ixti/cachew)

**DISCONTINUED**

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
# In-memory Hash
cache = Cachew::Hash.new

cache.fetch(:foo) { Time.now.to_i } # => 1405724687
cache.fetch(:foo) { Time.now.to_i } # => 1405724687

# With ttl
cache.fetch(:foo, :ttl => 10) { Time.now.to_i } # => 1405724689

# Before 10 seconds will expire
cache.fetch(:foo, :ttl => 10) { Time.now.to_i } # => 1405724689

# Once 10+ seconds pass
cache.fetch(:foo, :ttl => 10) { Time.now.to_i } # => 1405724695

# Withot cache (think of it as NullLogger)
cache = Cachew::Null.new

cache.fetch(:foo) { Time.now.to_i } # => 1405724687
cache.fetch(:foo) { Time.now.to_i } # => 1405724688
```

You can easily write your own adapters:

```
class Cachew::Redis < Cache::Adapter
  def initialize(client)
    @client = client
  end

  private

  def __set__(key, val, ttl)
    val = Marshal.dump val

    if 0 == ttl
      @client.set key, val
    else
      @client.setex key, val, ttl
    end
  end

  def __get__(key)
    val = @client.get(key)
    val ? Marshal.load(val) : UNDEFINED
  end

  def __key__(*)
    "cachew:#{super}"
  end
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/cachew/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
