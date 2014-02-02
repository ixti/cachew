class Cachew
  module Adapters
    class NullAdapter < BaseAdapter
      def set(_, value)
        value
      end

      def get(_)
        nil
      end

      def has?(_)
        false
      end
    end
  end
end
