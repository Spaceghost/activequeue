require 'helper'

class BeanstalkAdapterTest < Test::Unit::TestCase
  def message
    {:x => 'x'}.to_json
  end
  
  def test_send_and_recieve
    queue = ActiveQueue::QueueProvider.load_adapter('beanstalk').queue('a_queue')
    queue.send(message)
    assert_equal message, queue.receive
  end
  def test_size
    queue = ActiveQueue::QueueProvider.load_adapter('beanstalk').queue('a_queue')
    assert_equal 0, queue.size
    queue.send(message)
    assert_equal 1, queue.size
    queue.send(message)
    assert_equal 2, queue.size
    queue.receive
    assert_equal 1, queue.size
    queue.receive
    assert_equal 0, queue.size
  end
  def test_configuration
    configuration = {:hosts => ['127.0.0.1:11300']}
    adapter = ActiveQueue::QueueProvider.load_adapter('beanstalk', configuration)
    queue = adapter.queue('a_queue')
    queue.send(message)
    assert_equal message, queue.receive
  end
end