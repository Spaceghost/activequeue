begin
  require 'beanstalk-client'
rescue LoadError
  raise "Beanstalk-client not available."
end

module ActiveQueue #:nodoc:
  module QueueAdapters #:nodoc:
    class BeanstalkProvider < AbstractProvider #:nodoc:
      def queue(name)
        queues[name] ||= BeanstalkAdapter.new({
          :name => name, :hosts => @configuration[:hosts]
        })
      end
    end
    # A queue adapter for Beanstalk.
    class BeanstalkAdapter < AbstractQueueAdapter
      # Initialize the Beanstalk adapter.
      #
      # Options:
      # * <tt>:name</tt>: The name of the queue. The name defaults to 'default'
      # *<tt>:hosts</tt>: An array of host:port strings where beanstalkd is running.  
      # Defaults to ['localhost:11300']
      def initialize(options={})
        # beanstalk does not like underscores in tube names
        @name = (options[:name] ||= 'default').gsub(/_/, '-')
        @hosts = options[:hosts] ||= ['localhost:11300']
      end
      
      # Send a message to the beanstalk queue.
      def send(message)
        beanstalk.put(message)
      end
      
      # Receive the next message from the beanstalk queue.
      def receive
        visibility = 30
        message = beanstalk.reserve(visibility)
        body = message.body
        message.delete
        body
      end
      
      # Get the approximate queue size
      def size
        beanstalk.stats_tube(@name)['current-jobs-ready']
      end
      
      protected
      def beanstalk
        @beanstalk ||= Beanstalk::Pool.new(@hosts, @name)
      end
    end
  end
end