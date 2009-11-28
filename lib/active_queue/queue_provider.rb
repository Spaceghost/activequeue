module ActiveQueue #:nodoc:
  # A queue provider will give back a named queue using whatever queue adapter
  # was created at initialization.
  class QueueProvider
    # Get the named queue
    def self.queue(name)
      queue_adapter.queue(name)
    end
    
    # TODO: The methods below really should be for internal use only.
    
    # Initialize the adpater. Expects a configurations Hash with a top level key 
    # that matches RAILS_ENV.
    def self.initialize(configurations)
      configuration = configurations[RAILS_ENV]
      load_adapter(configuration['adapter'] || 'memory', configuration)
    end
    
    # Initialize the given named adapter.
    def self.initialize_adapter(adapter_name, configuration={})
      @queue_adapter = load_adapter(adapter_name, configuration)
    end
    
    # Load the named adapter. This will return an instance of the adapter.
    def self.load_adapter(adapter_name, configuration={})
      require "active_queue/queue_adapters/#{adapter_name}_adapter"
      adapter_provider = "#{adapter_name}_provider".camelize
      ActiveQueue::QueueAdapters.const_get(adapter_provider).new(configuration)
    end
  
    # Get a queue adapter instance
    def self.queue_adapter
      @queue_adapter ||= load_adapter('memory')
    end
  end
end