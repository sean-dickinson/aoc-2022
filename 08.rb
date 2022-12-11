module Day08
  class Grid
    class << self
      def from(input)
        rows = []
        input.each_with_index do |row, row_index|
          rows << []
          row.each_char.with_index do |value, column_index|
            rows[row_index] << Cell.new(row_index, column_index, value)
          end
        end
        new(rows)
      end
    end

    attr_reader :rows, :cells
    def initialize(rows)
      @rows = rows
      @cells = rows.flatten
    end

    def columns
      rows.transpose
    end

    def visible_count
      cells.count do |cell|
        is_visible?(cell)
      end
    end

    def is_visible?(cell)
      is_outside?(cell) ||
        sight_lines_for(cell).any? { |sight_line| cell.tallest_among?(sight_line) }
    end

    def scenic_score_for(cell)
      return 1 if is_outside?(cell)
      cell.scenic_score(*ordered_sight_lines_for(cell))
    end

    def ordered_sight_lines_for(cell)
      sight_lines_for(cell).map.with_index do |sight_line, index|
        if index.even?
          sight_line.reverse
        else
          sight_line
        end
      end
    end

    def sight_lines_for(cell)
      row_cells = cells.filter { |other_cell| other_cell.row_index == cell.row_index }
      column_cells = cells.filter { |other_cell| other_cell.column_index == cell.column_index }
      slice_array_around(row_cells, cell) + slice_array_around(column_cells, cell)
    end

    def slice_array_around(array, item)
      around_index = array.find_index { |other| other == item }
      [array[0...around_index], array[(around_index + 1)..]]
    end

    def is_outside?(cell)
      outside_column_indicies.include?(cell.column_index) ||
        outside_row_indicies.include?(cell.row_index)
    end

    def outside_column_indicies
      [0, columns.size - 1]
    end

    def outside_row_indicies
      [0, rows.size - 1]
    end
  end

  class Grid::Cell
    attr_reader :row_index, :column_index, :value
    def initialize(row_index, column_index, value)
      @row_index = row_index
      @column_index = column_index
      @value = value.to_i
    end

    def to_s
      "[#{row_index}, #{column_index}] - #{value}"
    end

    def <=(other)
      value <= other.value
    end

    def >(other)
      value > other.value
    end

    def <(other)
      value < other.value
    end

    def ==(other)
      row_index == other.row_index &&
        column_index == other.column_index &&
        value == other.value
    end

    def tallest_among?(cell_group)
      cell_group.all? { |other| other < self }
    end

    def scenic_score(*sight_lines)
      sight_lines
        .map { |sight_line|
          sight_line_score(sight_line)
        }
        .reduce(1, :*)
    end

    def sight_line_score(sight_line)
      sight_line.each_with_index do |tree, index|
        return index + 1 if self <= tree
      end
      sight_line.size
    end
  end

  class << self
    def part_one(input)
      grid = Grid.from(input)
      grid.visible_count
    end

    def part_two(input)
      grid = Grid.from(input)
      grid.cells.map { |cell| grid.scenic_score_for(cell) }.max
    end
  end
end
