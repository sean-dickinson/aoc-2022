module Day14
  class Point
    class << self
      def range(start, finish)
        if start.y == finish.y
          ordered_range(start.x, finish.x).map do |x|
            new(x, start.y)
          end
        else
          ordered_range(start.y, finish.y).map do |y|
            new(start.x, y)
          end
        end
      end

      private

      def ordered_range(start, finish)
        step = -1 * ((start - finish) / (start - finish).abs)
        (start..finish).step(step)
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

    alias_method :eql?, :==

    def hash
      [x, y].hash
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
    class << self
      def from(input, floor = false)
        rocks = points(input)
        x, y = grid_size(rocks)
        if floor
          y += 1
        end
        grid = new(x, y, floor)
        rocks.each do |point|
          grid.place(point, :rock)
        end
        grid
      end

      private

      def grid_size(points)
        max_row = points.map(&:x).max
        max_col = points.map(&:y).max
        [max_row + 1, max_col + 1]
      end

      def points(input)
        points = []
        input.each do |line|
          parser.parse(line)
            .each_cons(2) do |start, finish|
              points += Point.range(start, finish)
            end
        end
        points.uniq
      end

      def parser
        LineParser.new
      end
    end

    attr_reader :num_rows, :num_columns, :grid
    def initialize(x, y, floor = false)
      @num_rows = x
      @num_columns = y
      set_grid(floor)
    end

    def get(point)
      grid[point]
    end

    def place(point, item)
      @grid[point] = item
    end

    def occupied?(point)
      get(point) != :empty
    end

    def sand_count
      grid.values.count(:sand)
    end

    private

    def set_grid(floor = false)
      @grid = if floor
        floored_grid
      else
        Hash.new(:empty)
      end
    end

    def floored_grid
      Hash.new do |hash, point|
        hash[point] = if point.y == num_columns
          :floor
        else
          :empty
        end
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
        unless grid.occupied?(new_pos)
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
      grid = Grid.from(input)
      sand = Sand.new(500, 0)

      loop do
        break if sand.pos.y >= grid.num_columns
        unless sand.fall(grid)
          grid.place(sand.pos, :sand)
          sand = Sand.new(500, 0)
        end
      end

      grid.sand_count
    end

    def part_two(input)
      grid = Grid.from(input, true)
      sand = Sand.new(500, 0)

      loop do
        unless sand.fall(grid)
          grid.place(sand.pos, :sand)
          break if sand.pos == Point.new(500, 0)
          sand = Sand.new(500, 0)
        end
      end

      grid.sand_count
    end
  end
end
