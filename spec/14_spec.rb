require "./14"
describe Day14 do
  describe Day14::Point do
    describe "#self.range" do
      it "creates a range of points by interpolating the changing x coordinate" do
        start = Day14::Point.new(5, 10)
        finish = Day14::Point.new(10, 10)

        expected_points = [
          start,
          Day14::Point.new(6, 10),
          Day14::Point.new(7, 10),
          Day14::Point.new(8, 10),
          Day14::Point.new(9, 10),
          finish
        ]

        expect(Day14::Point.range(start, finish)).to eq(expected_points)
      end

      it "creates a range of points by interpolating the changing y coordinate" do
        start = Day14::Point.new(10, 5)
        finish = Day14::Point.new(10, 10)

        expected_points = [
          start,
          Day14::Point.new(10, 6),
          Day14::Point.new(10, 7),
          Day14::Point.new(10, 8),
          Day14::Point.new(10, 9),
          finish
        ]

        expect(Day14::Point.range(start, finish)).to eq(expected_points)
      end
    end

    describe "#move" do
      it "creates a new point moved by the deltas specified" do
        point = Day14::Point.new(7, 13)
        expected_point = Day14::Point.new(7, 14)

        expect(point.move(0, 1)).to eq(expected_point)
      end
    end
  end

  describe Day14::LineParser do
    describe "#parse" do
      it "coverts a line of input into an array of points" do
        parser = Day14::LineParser.new
        input = "498,4 -> 498,6 -> 496,6"
        expected_points = [
          Day14::Point.new(498, 4),
          Day14::Point.new(498, 6),
          Day14::Point.new(496, 6)
        ]

        expect(parser.parse(input)).to eq(expected_points)
      end
    end
  end

  describe Day14::Grid do
    describe "#new" do
      it "creates sets the number of rows and columns specified" do
        grid = Day14::Grid.new(10, 20)

        expect(grid.num_rows).to eq(10)
        expect(grid.num_columns).to eq(20)
      end

      it "creates a 2d array with the number of rows and columns specified" do
        grid = Day14::Grid.new(10, 20)

        expect(grid.grid).to have_exactly(10).items
        expect(grid.grid).to all(have_exactly(20).items)
      end
    end

    describe "#get" do
      it "gets the item at the given position" do
        grid = Day14::Grid.new(10, 20)

        expect(grid.get(0, 0)).to eq(:empty)
      end
    end

    describe "#place" do
      it "marks the given coordinate with the given symbol" do
        grid = Day14::Grid.new(500, 10)
        grid.place(498, 4, :rock)

        expect(grid.get(498, 4)).to eq(:rock)
      end
    end

    describe "#occupied?" do
      it "returns false if the location is not empty" do
        grid = Day14::Grid.new(10, 5)

        expect(grid.occupied?(1, 1)).to eq(false)
      end

      it "returns true if the location is taken by a rock" do
        grid = Day14::Grid.new(10, 5)
        grid.place(1, 1, :rock)

        expect(grid.occupied?(1, 1)).to eq(true)
      end

      it "returns true if the location is taken by sand" do
        grid = Day14::Grid.new(10, 5)
        grid.place(3, 4, :sand)

        expect(grid.occupied?(3, 4)).to eq(true)
      end

      it "throws an error if the given coordinate is lower than the lowest level" do
        grid = Day14::Grid.new(500, 10)

        expect { grid.occupied?(498, 10) }.to raise_error(Day14::Grid::OutOfBoundsError)
      end
    end
  end

  describe Day14::Sand do
    describe "#pos" do
      it "returns a point of the sand's position" do
        sand = Day14::Sand.new(500, 0)

        expected_point = Day14::Point.new(500, 0)

        expect(sand.pos).to eq(expected_point)
      end
    end

    describe "#fall" do
      it "moves the sand down one position if that space is available" do
        sand = Day14::Sand.new(500, 0)
        grid = Day14::Grid.new(550, 5)
        expected_pos = Day14::Point.new(500, 1)

        sand.fall(grid)

        expect(sand.pos).to eq(expected_pos)
      end

      it "moves the sand down and to the left if the space directly below the sand is occupied" do
        sand = Day14::Sand.new(500, 0)
        grid = Day14::Grid.new(550, 5)
        grid.place(500, 1, :rock)
        expected_pos = Day14::Point.new(499, 1)

        sand.fall(grid)

        expect(sand.pos).to eq(expected_pos)
      end

      it "moves the sand down and to the right if the space directly below the sand and below and to the left is occupied" do
        sand = Day14::Sand.new(500, 0)
        grid = Day14::Grid.new(550, 5)
        grid.place(500, 1, :rock)
        grid.place(499, 1, :rock)
        expected_pos = Day14::Point.new(501, 1)

        sand.fall(grid)

        expect(sand.pos).to eq(expected_pos)
      end

      it "returns false and does not move the sand if the sand is blocked in all locations" do
        sand = Day14::Sand.new(500, 0)
        grid = Day14::Grid.new(550, 5)
        grid.place(500, 1, :rock)
        grid.place(499, 1, :rock)
        grid.place(501, 1, :rock)
        original_position = sand.pos

        expect(sand.fall(grid)).to eq(false)
        expect(sand.pos).to eq(original_position)
      end
    end
  end
end
