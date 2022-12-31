module Day14
  class Point
    class << self
      def range(start, finish)
        if start.y == finish.y
          (start.x..finish.x).map do |x|
            new(x, start.y)
          end
        else
          (start.y..finish.y).map do |y|
            new(start.x, y)
          end
        end
      end
    end

    attr_reader :x, :y
    def initialize(x, y)
      @x = x
      @y = y
    end

    def move(dx, dy)
      self.class.new(x + dx, y + dy)
    end

    def ==(other)
      x == other.x && y == other.y
    end
  end

  class LineParser
    def parse(line)
      line.split("->")
        .map { |coor| coor.split(",").map(&:to_i) }
        .map { |coor| Point.new(*coor) }
    end
  end

  class Grid
    class OutOfBoundsError < StandardError; end

    attr_reader :num_rows, :num_columns, :grid
    def initialize(x, y)
      @num_rows = x
      @num_columns = y
      setup_grid
    end

    def get(x, y)
      grid[x][y]
    end

    def place(x, y, item)
      @grid[x][y] = item
    end

    def occupied?(x, y)
      raise OutOfBoundsError if y >= num_columns
      get(x, y) != :empty
    end

    private

    def setup_grid
      @grid = []
      num_rows.times do
        @grid << [].fill(:empty, 0, num_columns)
      end
    end
  end

  class Sand
    attr_reader :pos
    def initialize(x, y)
      @pos = Point.new(x, y)
    end

    def fall(grid)
      fall_options.each do |new_pos|
        unless grid.occupied?(new_pos.x, new_pos.y)
          @pos = new_pos
          return true
        end
      end
      false
    end

    private

    def fall_options
      [
        [0, 1],
        [-1, 1],
        [1, 1]
      ].map { |dx, dy| pos.move(dx, dy) }
    end
  end

  class << self
    def part_one(input)
      raise NotImplementedError
    end

    def part_two(input)
      raise NotImplementedError
    end
  end
end
