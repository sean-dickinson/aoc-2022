require "./04"
describe Day04 do
  describe "Assignment::Pair" do
    describe "#self.from" do
      it "returns an assignment pair from a line of text" do
        line = "2-4,6-8"
        assignment_1 = Day04::Assignment.new("2-4")
        assignment_2 = Day04::Assignment.new("6-8")
        expected_pair = Day04::Assignment::Pair.new(assignment_1, assignment_2)
        pair = Day04::Assignment::Pair.from(line)

        expect(pair).to eq(expected_pair)
      end
    end
    describe "#full_overlap?" do
      it "returns true if one of the assignment pairs cover? the other" do
        assignment_1_double = double("assignment", cover?: true)
        assignment_2_double = double("assignment", cover?: false)

        pair = Day04::Assignment::Pair.new(assignment_1_double, assignment_2_double)

        expect(pair.full_overlap?).to be(true)
      end

      it "returns false if neither of the assignment pairs cover? the other" do
        assignment_1_double = double("assignment", cover?: false)
        assignment_2_double = double("assignment", cover?: false)

        pair = Day04::Assignment::Pair.new(assignment_1_double, assignment_2_double)

        expect(pair.full_overlap?).to be(false)
      end
    end

    describe "#any_overlap?" do
      it "returns true if the assignment pair contains any overlap" do
        assignment_1_double = double("assignment", overlaps?: true)
        assignment_2_double = double("assignment")

        pair = Day04::Assignment::Pair.new(assignment_1_double, assignment_2_double)

        expect(pair.any_overlap?).to be(true)
      end
    end
  end

  describe "Assignment" do
    describe "#range" do
      it "returns the range for the input given" do
        [
          ["2-4", (2..4)],
          ["6-6", (6..6)]
        ].each do |input, expected_range|
          assignment = Day04::Assignment.new(input)

          expect(assignment.range).to eq(expected_range)
        end
      end
    end
    describe "#cover?" do
      it "returns true if the other assignment is fully covered by this assignment" do
        assignment = Day04::Assignment.new("2-5")
        other_assignment = Day04::Assignment.new("4-5")

        expect(assignment.cover?(other_assignment)).to be(true)
      end

      it "returns false if the other assignment is not fully covered by this assignment" do
        assignment = Day04::Assignment.new("4-5")
        other_assignment = Day04::Assignment.new("2-5")

        expect(assignment.cover?(other_assignment)).to be(false)
      end
    end
    describe "#overlaps?" do
      it "returns true if there is any overlap between this assignment and the other given" do
        assignment = Day04::Assignment.new("4-5")
        other_assignment = Day04::Assignment.new("2-5")

        expect(assignment.overlaps?(other_assignment)).to be(true)
      end

      it "returns false if there is no overlap between this assignment and the other given" do
        assignment = Day04::Assignment.new("7-8")
        other_assignment = Day04::Assignment.new("2-5")

        expect(assignment.overlaps?(other_assignment)).to be(false)
      end
    end
  end

  describe "#part_one" do
    it "calculates the number of pairs where a full overlap is present" do
      input = File.readlines("spec/test_inputs/04.txt", chomp: true)
      expect(Day04.part_one(input)).to eq(2)
    end
  end

  describe "#part_two" do
    it "calculates the number of assignment pairs where any overlap is present" do
      input = File.readlines("spec/test_inputs/04.txt", chomp: true)
      expect(Day04.part_two(input)).to eq(4)
    end
  end
end
