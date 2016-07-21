require 'minitest/autorun'
require 'my_chart'
require 'tasks'

class TestGroup < MiniTest::Unit::TestCase

  def test_group_method_return_task_itself
    t = nil

    MyChart.js do
      material [1]
      t = group by: :odd_or_even do |n|
        n.odd? ? 'odd' : 'even'
      end
    end

    assert_equal Tasks::Task, t.class
  end
end