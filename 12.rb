module Day12
  class Maze
    attr_reader :start, :finish
    private attr_reader :rows
    def initialize(input)
      @rows = parse_input(input)
      set_start_and_finish
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

    def set_start_and_finish
      flattened_rows = rows.to_a.flatten
      @start = flattened_rows.find(&:is_start?)
      @finish = flattened_rows.find(&:is_finish?)
    end

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

    def pos
      [row, col]
    end

    def ==(other)
      other.row == row && other.col == col && other.height == height
    end

    def to_s
      "(#{row}, #{col}) #{height}"
    end

    def can_step_to?(other)
      allowed_steps.include?(other.true_height)
    end

    def is_start?
      height == "S"
    end

    def is_finish?
      height == "E"
    end

    protected

    def true_height
      {
        "E" => "z",
        "S" => "a"
      }.fetch(height, height)
    end

    private

    def allowed_steps
      return ["z"] if true_height == "z"
      ("a".."z").each_cons(2).find { |start, stop| start == true_height }
    end
  end

  class Solver
    private attr_reader :maze, :queue, :visited_cells
    def initialize(maze)
      @maze = maze
      @visited_cells = []
      initialize_queue
    end

    def shortest_path
      until queue.empty?
        cell, steps = queue.pop
        if cell.is_finish?
          return steps
        else
          enqueue_neighbors(cell, steps + 1)
        end
      end
      puts "visited #{visited_cells.size} cells and found no solution"
    end

    private

    def initialize_queue
      @queue = Queue.new
      @queue << [maze.start, 0]
      mark_as_visited(maze.start)
    end

    def enqueue_neighbors(cell, steps)
      neighbors_to_queue(cell).each do |neighbor|
        mark_as_visited(neighbor)
        queue << [neighbor, steps]
      end
    end

    def mark_as_visited(cell)
      visited_cells << cell
    end

    def neighbors_to_queue(cell)
      maze.get_valid_neighbors(cell) - visited_cells
    end
  end

  class << self
    def part_one(input)
      maze = Maze.new(input)
      Solver.new(maze).shortest_path
    end

    def part_two(input)
    end
  end
end
