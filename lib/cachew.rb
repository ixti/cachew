require "cachew/version"
require "cachew/adapters"

# Unified cache interface
class Cachew
  extend Forwardable

  attr_reader :adapter

  def initialize(store = nil)
    @adapter = Adapters.build_adapter_for store
  end

  def fetch(key)
    has?(key) ? get(key) : set(key, yield)
  end

  def_delegators :adapter, :set, :get, :has?
end
