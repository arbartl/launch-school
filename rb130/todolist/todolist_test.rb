require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!


require_relative 'todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@todos.size, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    todo = @list.shift
    assert_equal(@todo1, todo)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
    @list.mark_all_done
    assert_equal(true, @list.done?)
  end

  def test_typeerror
    assert_raises(TypeError) { @list << 1 }
    assert_raises(TypeError) { @list << 'hi' }
  end

  def test_shovel
    @todos4 = Todo.new("test")
    @todos << @todos4
    @list << @todos4
    assert_equal(@todos, @list.to_a)
  end

  def test_add
    @todos4 = Todo.new("test")
    @todos << @todos4
    @list << @todos4
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    item = @list.item_at(0)
    assert_equal(item, @todos[0])
    item = @list.item_at(2)
    assert_equal(item, @todos[2])
    assert_raises(IndexError) { @list.item_at(100) }
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(100) }
    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(100) }
    @list.mark_done_at(0)
    @list.mark_done_at(1)
    @list.mark_undone_at(0)
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_done!
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }
    item = @list.remove_at(1)
    assert_equal(item, @todo2)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)

    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    result = []
    @list.each { |todo| result << todo }
    assert_equal(@list.to_a, result)

    assert_equal(@list, @list.each {})
  end

  def test_select
    refute_same(@list, @list.select {true})
  end

  def test_find_by_title
    item = @list.find_by_title(@todo1.title)
    assert_equal(item, @todo1)
  end

  def test_all_done
    @todo1.done!
    list = TodoList.new(@list.title)
    list << @todo1
    assert_equal(list, @list.all_done)
  end

  def test_all_not_done
    list = @list.clone
    assert_equal(list, @list.all_not_done)
  end

  def test_mark_done
    @list.mark_done(@todo1.title)
    assert_equal(true, @todo1.done?)
  end

  def test_mark_all_undone
    @todo1.done!
    @todo1.undone!
    assert_equal([@todo1, @todo2, @todo3], @list.mark_all_undone.to_a)
  end
end