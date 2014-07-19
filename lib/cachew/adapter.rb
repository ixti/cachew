require "digest/md5"
require "json"

module Cachew
  # Base class for Cachew adapters.
  #
  # @example Building custom adapters
  #
  #     class Cachew::Redis < Cache::Adapter
  #       def initialize(client)
  #         @client = client
  #       end
  #
  #       private
  #
  #       def __set__(key, val, ttl)
  #         val = Marshal.dump val
  #
  #         if 0 == ttl
  #           @client.set key, val
  #         else
  #           @client.setex key, val, ttl
  #         end
  #       end
  #
  #       def __get__(key)
  #         val = @client.get(key)
  #         val ? Marshal.load(val) : UNDEFINED
  #       end
  #
  #       def __key__(*)
  #         "cachew:#{super}"
  #       end
  #     end
  #
  class Adapter
    # Internal constant used by `__get__` to notify that value is not in the
    # cache or became stale
    UNDEFINED = Object.new.freeze

    # @example Usage
    #
    #   cachew.fetch "some_key", :ttl => 60 do
    #     HTTP.get("http://example.com").to_s
    #   end
    #
    def fetch(key, opts = {})
      key = __key__ key, opts
      val = __get__ key

      if UNDEFINED.equal? val
        val = yield
        ttl = opts.fetch(:ttl) { 0 }.to_i

        __set__ key, val, ttl
      end

      val
    end

    private

    # :nodoc:
    def __set__(_key, _val, _ttl)
      fail "Not implemented"
    end

    # :nodoc:
    def __get__(_key)
      fail "Not implemented"
    end

    # :nodoc:
    def __key__(*args)
      Digest::MD5.hexdigest JSON.dump args
    end
  end
end
