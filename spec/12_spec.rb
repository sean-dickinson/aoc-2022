require "./12"
describe Day12 do
  describe Day12::Maze do
    describe "#new" do
      it "creates a maze with the correct dimensions from the input" do
        input = [
          "Sacx",
          "aabE"
        ]
        maze = Day12::Maze.new(input)
        expect(maze.num_columns).to eq(4)
        expect(maze.num_rows).to eq(2)
      end
    end

    describe "#possible_starts" do
      it "returns all cells that have an elevation of a" do
        input = [
          "abbc",
          "SabE",
          "abbc"
        ]
        maze = Day12::Maze.new(input)
        expected_cells = [
          [0, 0],
          [1, 0],
          [1, 1],
          [2, 0]
        ].map { |pos| maze.get(*pos) }

        expect(maze.possible_starts).to contain_exactly(*expected_cells)
      end
    end

    describe "#start" do
      it "returns the cell that is the start of the maze" do
        input = [
          "aacx",
          "SabE"
        ]
        expected_start = Day12::Cell.new(1, 0, "S")
        maze = Day12::Maze.new(input)
        expect(maze.start).to eq(expected_start)
      end
    end

    describe "#finish" do
      it "returns the cell that is the end of the maze" do
        input = [
          "aacx",
          "SabE"
        ]
        maze = Day12::Maze.new(input)
        expected_finish = Day12::Cell.new(1, 3, "E")
        expect(maze.finish).to eq(expected_finish)
      end
    end

    describe "#get" do
      it "returns the cell at the given position" do
        input = [
          "ab",
          "cd"
        ]
        expected_cells = {
          [0, 0] => Day12::Cell.new(0, 0, "a"),
          [0, 1] => Day12::Cell.new(0, 1, "b"),
          [1, 0] => Day12::Cell.new(1, 0, "c"),
          [1, 1] => Day12::Cell.new(1, 1, "d")

        }
        maze = Day12::Maze.new(input)

        expected_cells.each do |pos, cell|
          expect(maze.get(*pos)).to eq(cell)
        end
      end
    end

    describe "#get_valid_neighbors" do
      it "gets the position and height from the cell" do
        input = [
          "ab",
          "bb"
        ]
        maze = Day12::Maze.new(input)
        cell = double("cell")
        expect(cell).to receive(:pos).and_return([0, 0])
        expect(cell).to receive(:can_step_to?).at_most(4).times
        maze.get_valid_neighbors(cell)
      end

      it "returns the neigboring cells for the top left corner cell" do
        input = [
          "ab",
          "bc"
        ]
        maze = Day12::Maze.new(input)
        cell = maze.get(0, 0) # top left a
        expected_neighbors = [
          [0, 1],
          [1, 0]
        ].map { |pos| maze.get(*pos) }
        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end

      it "returns the neigboring cells for the bottom left corner cell" do
        input = [
          "bc",
          "ab"
        ]
        maze = Day12::Maze.new(input)
        cell = maze.get(1, 0) # bottom left a
        expected_neighbors = [
          [0, 0],
          [1, 1]
        ].map { |pos| maze.get(*pos) }
        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end

      it "returns the neigboring cells for the bottom right corner cell" do
        input = [
          "cb",
          "ba"
        ]
        maze = Day12::Maze.new(input)
        cell = maze.get(1, 1) # bottom right a
        expected_neighbors = [
          [1, 0],
          [0, 1]
        ].map { |pos| maze.get(*pos) }
        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end

      it "returns the neigboring cells for the top right corner cell" do
        input = [
          "ba",
          "cb"
        ]
        maze = Day12::Maze.new(input)
        cell = maze.get(0, 1) # bottom right a
        expected_neighbors = [
          [0, 0],
          [1, 1]
        ].map { |pos| maze.get(*pos) }
        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end

      it "returns the 4 possible cells for a middle cell" do
        input = [
          "cbc",
          "bab",
          "cbc"
        ]
        maze = Day12::Maze.new(input)
        cell = maze.get(1, 1) # middle a
        expected_neighbors = [
          [0, 1],
          [1, 0],
          [1, 2],
          [2, 1]
        ].map { |pos| maze.get(*pos) }

        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end

      it "returns the 3 possible cells for a bottom row cell" do
        input = [
          "cbc",
          "bab"
        ]
        maze = Day12::Maze.new(input)
        cell = maze.get(1, 1) # bottom a
        expected_neighbors = [
          [1, 0],
          [1, 2],
          [0, 1]
        ].map { |pos| maze.get(*pos) }

        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end

      it "returns the 3 possible cells for a right edge cell" do
        input = [
          "ccb",
          "cba",
          "ccb"
        ]
        maze = Day12::Maze.new(input)
        cell = maze.get(1, 2) # right most a
        expected_neighbors = [
          [0, 2],
          [1, 1],
          [2, 2]
        ].map { |pos| maze.get(*pos) }

        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end

      it "returns the 3 possible cells for a left edge cell" do
        input = [
          "bcc",
          "abc",
          "bcc"
        ]
        maze = Day12::Maze.new(input)
        cell = maze.get(1, 0) # left most a
        expected_neighbors = [
          [0, 0],
          [1, 1],
          [2, 0]
        ].map { |pos| maze.get(*pos) }

        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end

      it "returns the 3 possible cells for a top edge cell" do
        input = [
          "bab",
          "cbc"
        ]
        maze = Day12::Maze.new(input)
        cell = maze.get(0, 1) # top most a
        expected_neighbors = [
          [0, 0],
          [0, 2],
          [1, 1]
        ].map { |pos| maze.get(*pos) }

        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end
    end
  end

  describe Day12::Cell do
    describe "#pos" do
      it "returns the [row, col] indexes" do
        cell = Day12::Cell.new(1, 2, "a")
        expect(cell.pos).to eq([1, 2])
      end
    end
    describe "#can_step_to?" do
      it "returns true if the neighboring cell is the same height" do
        cell = Day12::Cell.new(0, 0, "a")
        other_cell = Day12::Cell.new(0, 1, "a")

        expect(cell.can_step_to?(other_cell)).to eq true
      end

      it "returns true if the neighboring cell is one step higher than the current cell" do
        cell = Day12::Cell.new(0, 0, "a")
        other_cell = Day12::Cell.new(0, 1, "b")

        expect(cell.can_step_to?(other_cell)).to eq true
      end

      it "returns true if the neighboring cell is lower than the current cell" do
        cell = Day12::Cell.new(0, 0, "c")
        other_cell = Day12::Cell.new(0, 1, "b")

        expect(cell.can_step_to?(other_cell)).to eq true
      end

      it "treats the start cell as height a" do
        start_cell = Day12::Cell.new(0, 0, "S")
        [
          Day12::Cell.new(0, 1, "a"),
          Day12::Cell.new(0, 1, "b")
        ].each do |other_cell|
          expect(start_cell.can_step_to?(other_cell)).to eq true
        end
      end

      it "treats the finish cell as height z" do
        [
          Day12::Cell.new(0, 0, "y"),
          Day12::Cell.new(0, 0, "z")
        ].each do |cell|
          end_cell = Day12::Cell.new(0, 1, "E")
          expect(cell.can_step_to?(end_cell)).to eq true
        end
      end

      it "returns false if the neighboring cell is more than one step higher than the current cell" do
        all_heights = ("a".."z").to_a
        all_heights.each_with_index.first(24) do |height, index|
          cell = Day12::Cell.new(0, 0, height)
          higher_than_1 = index + 2
          all_heights[higher_than_1...].each do |h|
            other_cell = Day12::Cell.new(0, 0, h)
            expect(cell.can_step_to?(other_cell)).to eq false
          end
        end
      end
    end
  end

  describe "#part_one" do
    it "finds the number of steps in the shortest path" do
      input = File.readlines("spec/test_inputs/12.txt", chomp: true)
      expect(Day12.part_one(input)).to eq(31)
    end
  end

  describe "#part_two" do
    it "finds the number of steps in the shortest path from any starting point" do
      input = File.readlines("spec/test_inputs/12.txt", chomp: true)
      expect(Day12.part_two(input)).to eq(29)
    end
  end
end
