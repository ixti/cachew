require "cachew/adapters/base_adapter"
require "cachew/adapters/hash_adapter"
require "cachew/adapters/null_adapter"

class Cachew
  module Adapters
    def self.build_adapter_for(store)
      case store
      when BaseAdapter  then store
      when Hash         then HashAdapter.new(store)
      else                   NullAdapter.new
      end
    end
  end
end
