module ActiveQueue #:nodoc:
  module QueueAdapters #:nodoc:
    class MemoryProvider < AbstractProvider #:nodoc:
      def queue(name)
        queues[name] ||= MemoryAdapter.new({:name => name})
      end
    end
    # A simple in-memory queue.
    class MemoryAdapter < AbstractQueueAdapter
      def initialize(options={})
        @name = options[:name] ||= 'default'
        @queue = []
      end
      def send(message)
        @queue.push(message)
      end
      def receive
        @queue.shift
      end
      def size
        @queue.length
      end
    end
  end
end