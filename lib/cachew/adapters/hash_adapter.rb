class Cachew
  module Adapters
    class HashAdapter < BaseAdapter
      def set(key, value)
        store[key] = value
      end

      def get(key)
        store[key]
      end

      def has?(key)
        store.key?(key)
      end
    end
  end
end
