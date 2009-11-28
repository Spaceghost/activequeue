require 'helper'

class QueueProviderTest < Test::Unit::TestCase
  def test_defaults
    message = {:x => 'x'}
    queue = ActiveQueue::QueueProvider.queue('a_queue')
    assert_equal ActiveQueue::QueueAdapters::MemoryAdapter, queue.class
    queue.send(message)
    assert_equal message, queue.receive
    assert_equal nil, queue.receive
  end
end