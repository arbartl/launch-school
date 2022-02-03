class Element
  attr_accessor :datum, :next
  
  def initialize(datum, next_element=nil)
    @datum = datum
    @next = next_element
  end

  def tail?
    !@next
  end
end

class SimpleLinkedList
  attr_reader :head

  def self.from_a(arr)
    arr = arr.clone
    list = SimpleLinkedList.new
    return list unless arr
    until arr.empty?
      list.push(arr.pop)
    end
    list
  end

  def initialize
    @head = nil
  end

  def size
    return 0 unless @head
    count = 1
    current = @head
    loop do
      break unless current.next
      count += 1
      current = current.next
    end
    count
  end

  def empty?
    !head
  end

  def peek
    head ? head.datum : nil
  end

  def push(value)
    @head = Element.new(value, head)
  end

  def pop
    popped = head.datum
    @head = head.next
    popped
  end

  def to_a
    arr = []
    return arr unless head
    current = head
    loop do
      arr << current.datum
      break unless current.next
      current = current.next
    end
    arr
  end

  def reverse
    SimpleLinkedList.from_a(self.to_a.reverse)
  end
end
