module ActiveQueue #:nodoc:
  module QueueAdapters #:nodoc:
    # An abstract interface that queues must implement.
    class AbstractQueueAdapter
      # Send a message to the queue
      def send(message)
        raise NotImplementedError
      end
      
      # Receive the next message in the queue
      def receive
        raise NotImplementedError
      end
      
      # Return the approximate queue size
      def size
        raise NotImplementedError
      end
    end
  end
end