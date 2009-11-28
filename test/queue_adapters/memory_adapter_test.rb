require 'helper'

class MemoryAdapterTest < Test::Unit::TestCase
  def test_send_and_recieve
    message = {:x => 'x'}
    queue = ActiveQueue::QueueProvider.load_adapter('memory').queue('a_queue')
    queue.send(message)
    assert_equal message, queue.receive
  end
  def test_size
    message = {:x => 'x'}
    queue = ActiveQueue::QueueProvider.load_adapter('memory').queue('a_queue')
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
end