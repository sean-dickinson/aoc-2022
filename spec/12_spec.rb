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

    describe "#get_valid_neighbors" do
      it "gets the position and height from the cell" do
        input = [
          "Sacx",
          "aabE"
        ]
        maze = Day12::Maze.new(input)
        cell = double("cell")
        expect(cell).to receive(:pos).and_return([0, 0])
        expect(cell).to receive(:can_step_to?).at_most(4).times
        maze.get_valid_neighbors(cell)
      end

      it "returns the neigboring cells for the corner cell" do
        input = [
          "Sacx",
          "aabE"
        ]
        expected_neighbors = [
          Day12::Cell.new(0, 1, "a"),
          Day12::Cell.new(1, 0, "a")
        ]
        maze = Day12::Maze.new(input)
        cell = double("cell")
        expect(cell).to receive(:pos).and_return([0, 0])
        expect(cell).to receive(:can_step_to?).exactly(2).times.and_return(true)
        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end

      it "returns the 4 possible cells for a middle cell" do
        input = [
          "Sacx",
          "aabE",
          "aabb"
        ]
        expected_neighbors = [
          Day12::Cell.new(0, 1, "a"),
          Day12::Cell.new(1, 0, "a"),
          Day12::Cell.new(1, 2, "b"),
          Day12::Cell.new(2, 1, "a")
        ]
        maze = Day12::Maze.new(input)
        cell = double("cell")
        expect(cell).to receive(:pos).and_return([1, 1])
        expect(cell).to receive(:can_step_to?).exactly(4).times.and_return(true)
        expect(maze.get_valid_neighbors(cell)).to contain_exactly(*expected_neighbors)
      end
    end
  end

  describe Day12::Cell do
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

      it "returns true if the cell is the start cell" do
        start_cell = Day12::Cell.new(0, 0, "S")
        other_cell = Day12::Cell.new(0, 1, "a")
        expect(start_cell.can_step_to?(other_cell)).to eq true
      end

      it "returns true if the neigbhoring cell end cell" do
        cell = Day12::Cell.new(0, 0, "a")
        end_cell = Day12::Cell.new(0, 1, "E")
        expect(cell.can_step_to?(end_cell)).to eq true
      end

      it "returns false if the neighboring cell is more than one step higher than the current cell" do
        cell = Day12::Cell.new(0, 0, "a")
        [
          Day12::Cell.new(0, 1, "c"),
          Day12::Cell.new(0, 1, "d"),
          Day12::Cell.new(0, 1, "h"),
          Day12::Cell.new(0, 1, "z")
        ].each do |other_cell|
          expect(cell.can_step_to?(other_cell)).to eq false
        end
      end
    end
  end

  describe "#part_one" do
    it "finds the number of steps in the shortest path" do
      skip
      input = File.readlines("spec/test_inputs/12.txt", chomp: true)
      expect(Day12.part_one(input)).to eq(31)
    end
  end

  describe "#part_two" do
    it "?" do
      skip
      # input = File.readlines("spec/test_inputs/12.txt", chomp: true)
    end
  end
end
