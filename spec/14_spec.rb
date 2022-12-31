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
  end
end
