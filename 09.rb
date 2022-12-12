module Day09
  class Rope
    def initialize(x, y, num_knots = 2)
      @knots = []
      (num_knots - 1).times do |knot|
        @knots << Knot.new(x, y)
      end
      @head = @knots.first
      @tail = Tail.new(x, y)
      @knots << @tail
    end

    def move(direction, amount)
      amount.times do
        @head.move(*move_mapping.fetch(direction))
        leader = @head
        @knots[1..].each do |knot|
          knot.follow(leader)
          leader = knot
        end
      end
    end

    def tail_position_count
      @tail.positions.uniq.size
    end

    private

    def move_mapping
      {
        "R" => [:x, 1],
        "L" => [:x, -1],
        "U" => [:y, 1],
        "D" => [:y, -1]
      }
    end
  end

  class Rope::Knot
    attr_accessor :x, :y
    def initialize(x, y)
      @x = x
      @y = y
    end

    def pos
      [x, y]
    end

    def move(axis, increment)
      send("#{axis}=", increment.to_i + send(axis))
    end

    def follow(other)
      dx, dy = delta_from(other)
      return if dx.abs <= 1 && dy.abs <= 1
      if (dx - dy).abs == 2
        move(:x, (dx * 0.5))
        move(:y, (dy * 0.5))
      else
        move(:x, increment_for_delta(dx))
        move(:y, increment_for_delta(dy))
      end
    end

    private

    def delta_from(other)
      [other.x - x, other.y - y]
    end

    def increment_for_delta(d)
      if d > 0
        (d / 2.0).ceil
      else
        d / 2
      end
    end
  end

  class Rope::Tail < Rope::Knot
    attr_reader :positions
    def initialize(x, y)
      super(x, y)
      @positions = [pos]
    end

    def follow(other)
      super(other)
      @positions << pos
    end
  end

  class << self
    def part_one(input)
      rope = Rope.new(0, 0)
      input.each do |instruction|
        rope.move(*parse_instruction(instruction))
      end
      rope.tail_position_count
    end

    def part_two(input)
      rope = Rope.new(0, 0, 10)
      input.each do |instruction|
        rope.move(*parse_instruction(instruction))
      end
      rope.tail_position_count
    end

    private

    def parse_instruction(instruction)
      direction, amount = instruction.split
      [direction, amount.to_i]
    end
  end
end
