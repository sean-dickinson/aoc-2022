require "./08"
describe Day08 do
  describe "Grid::Cell" do
    describe "#new" do
      it "defines a row_index, column_index, and value as attr_readers" do
        row_index = 0
        column_index = 0
        value = "5"
        cell = Day08::Grid::Cell.new(row_index, column_index, value)
        expect(cell.row_index).to eq(row_index)
        expect(cell.column_index).to eq(column_index)
        expect(cell.value).to eq(value.to_i)
      end
    end
    describe "#> and #<" do
      it "defers the > and < operations to value" do
        cell = Day08::Grid::Cell.new(0, 0, 5)
        smaller_cell = Day08::Grid::Cell.new(0, 1, 4)
        expect(cell).to be > smaller_cell
        expect(smaller_cell).to be < cell
      end
    end

    describe "#tallest_among?" do
      it "returns true if the cell is larger than all cells in the group given" do
        cell = Day08::Grid::Cell.new(0, 0, 5)
        smaller_cells = [
          Day08::Grid::Cell.new(0, 1, 4),
          Day08::Grid::Cell.new(0, 2, 1),
          Day08::Grid::Cell.new(0, 3, 3)
        ]

        expect(cell).to be_tallest_among(smaller_cells)
      end

      it "returns false if at least one cell in the group given is larger" do
        cell = Day08::Grid::Cell.new(0, 0, 5)
        cell_group = [
          Day08::Grid::Cell.new(0, 1, 6),
          Day08::Grid::Cell.new(0, 2, 1),
          Day08::Grid::Cell.new(0, 3, 3)
        ]

        expect(cell).not_to be_tallest_among(cell_group)
      end

      it "returns false if at least one cell in the group given is the same size" do
        cell = Day08::Grid::Cell.new(0, 0, 5)
        cell_group = [
          Day08::Grid::Cell.new(0, 1, 5),
          Day08::Grid::Cell.new(0, 2, 1),
          Day08::Grid::Cell.new(0, 3, 3)
        ]

        expect(cell).not_to be_tallest_among(cell_group)
      end
    end

    describe "#sight_line_score" do
      it "returns the sight_line_score of 1 if it can only see 1 tree" do
        # Sight line where cell under test is 1
        # 2 1 1
        cell = Day08::Grid::Cell.new(0, 2, 1)
        sight_line = [
          Day08::Grid::Cell.new(0, 1, 1),
          Day08::Grid::Cell.new(0, 0, 2)
        ]

        expect(cell.sight_line_score(sight_line)).to eq(1)
      end

      it "returns the sight_line_score of 2 if it can see 2 trees" do
        # Sight line where cell under test is 3
        # 1 2 3
        cell = Day08::Grid::Cell.new(0, 2, 3)
        sight_line = [
          Day08::Grid::Cell.new(0, 1, 2),
          Day08::Grid::Cell.new(0, 0, 1)
        ]

        expect(cell.sight_line_score(sight_line)).to eq(2)
      end
    end

    describe "#scenic_score" do
      it "returns the product of all sight_line_scores" do
        input = File.readlines("spec/test_inputs/08.txt", chomp: true)
        grid = Day08::Grid.from(input)
        middle_5 = grid.cells.find { |cell| cell.row_index == 1 && cell.column_index == 2 }

        expect(grid.scenic_score_for(middle_5)).to eq(4)
      end
    end
  end

  describe "Grid" do
    describe "self.#from" do
      it "constructs a grid from the input" do
        input = [
          "123",
          "123",
          "123"
        ]

        grid = Day08::Grid.from(input)

        expect(grid.columns.size).to eq(3)
        expect(grid.rows.size).to eq(3)
      end
    end

    describe "#columns" do
      it "returns the columns of the grid" do
        # 1 2
        # 3 4
        grid = Day08::Grid.new(
          [
            [
              Day08::Grid::Cell.new(0, 0, 1),
              Day08::Grid::Cell.new(0, 1, 2)
            ],
            [
              Day08::Grid::Cell.new(1, 0, 3),
              Day08::Grid::Cell.new(1, 1, 4)
            ]
          ]
        )

        # 1 3
        # 2 4
        expected_columns = [
          [
            Day08::Grid::Cell.new(0, 0, 1),
            Day08::Grid::Cell.new(1, 0, 3)
          ],
          [
            Day08::Grid::Cell.new(0, 1, 2),
            Day08::Grid::Cell.new(1, 1, 4)

          ]
        ]

        expect(grid.columns).to eq(expected_columns)
      end
    end
  end

  describe "#part_one" do
    it "counts the number of visible trees" do
      input = File.readlines("spec/test_inputs/08.txt", chomp: true)
      expect(Day08.part_one(input)).to eq(21)
    end
  end

  describe "#part_two" do
    it "finds the highest scenic score" do
      input = File.readlines("spec/test_inputs/08.txt", chomp: true)
      expect(Day08.part_two(input)).to eq(8)
    end
  end
end
