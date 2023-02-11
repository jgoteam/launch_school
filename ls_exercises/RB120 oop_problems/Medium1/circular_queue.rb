class CircularQueue

  def initialize(size)
    @circle = Array.new(size)
    @size = size
  end

  def enqueue(new_item)
    circle.push(new_item)
    circle.shift if circle.size > size
  end

  def dequeue
    circle.compact!
    circle.shift
  end

  private

  attr_reader :size, :circle
end
