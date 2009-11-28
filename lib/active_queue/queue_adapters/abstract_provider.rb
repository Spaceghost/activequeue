module ActiveQueue #:nodoc:
  module QueueAdapters #:nodoc:
    # Internal abstract base for provider implementations.
    class AbstractProvider
      def initialize(configuration={})
        @configuration = configuration
      end
      def queues
        @queues ||= {}
      end
    end
  end
end