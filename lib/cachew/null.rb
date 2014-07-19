require "cachew/adapter"

module Cachew
  # Null version of Cachew. Never caches anything, and returns value of given
  # block directly.
  class Null < Adapter
    class << self
      # Returns singleton instance of Null adapter.
      # @return [Null]
      def new
        @instance ||= super
      end
    end

    private

    # :nodoc:
    def __get__(*)
      UNDEFINED
    end

    # :nodoc:
    def __set__(*) end

    # :nodoc:
    def __key__(*) end
  end
end
