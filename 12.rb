module Day12
  class Maze
    private attr_reader :rows
    def initialize(input)
      @rows = parse_input(input)
    end

    def num_columns
      rows.first.size
    end

    def num_rows
      rows.size
    end

    def get_valid_neighbors(cell)
      get_neighbors(cell.pos).filter { |neighbor| cell.can_step_to?(neighbor) }
    end

    private

    def parse_input(input)
      input.map.with_index { |line, row|
        line.each_char.map.with_index { |height, col| Cell.new(row, col, height) }
      }
    end

    def get_neighbors(pos)
      neighbor_coords(*pos).map { |r, c| rows[r][c] }
    end

    def neighbor_coords(row, col)
      [
        [row - 1, col],
        [row + 1, col],
        [row, col - 1],
        [row, col + 1]
      ].reject { |pos| invalid_coord?(*pos) }
    end

    def invalid_coord?(row, col)
      row < 0 ||
        row >= num_rows ||
        col < 0 ||
        col >= num_columns
    end
  end

  class Cell
    attr_reader :row, :col, :height
    def initialize(row, col, height)
      @row = row
      @col = col
      @height = height
    end

    def ==(other)
      other.row == row && other.col == col && other.height == height
    end

    def can_step_to?(other)
      allowed_steps.include?(other.height)
    end

    def is_start?
      height == "S"
    end

    private

    def allowed_steps
      return ["a"] if is_start?
      slice = ("a".."z").each_slice(2).find { |start, stop| start == height }
      ["E", *slice]
    end
  end

  class << self
    def part_one(input)
    end

    def part_two(input)
    end
  end
end
