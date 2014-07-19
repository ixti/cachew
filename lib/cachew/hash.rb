require "cachew/adapter"

module Cachew
  # In-memory cache adapter.
  class Hash < Adapter
    # @param [#to_hash] store Underlying Hash used for storage
    def initialize(store = {})
      @store = store.to_hash
    end

    private

    # :nodoc:
    def __set__(key, val, ttl)
      ttl = 0 >= ttl ? 0 : Time.now.to_i + ttl
      @store[key] = [val, ttl]
    end

    # :nodoc:
    def __get__(key)
      val, ttl = @store[key]
      ttl && (0 == ttl || ttl > Time.now.to_i) ? val : UNDEFINED
    end
  end
end
