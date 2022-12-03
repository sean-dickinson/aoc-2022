require "./02"
describe Day02 do
  describe "Play" do
    describe "self.for_result" do
      it "returns a losing play when the code is X" do
        result_code = "X"
        opponent = Day02::Rock.new

        result = Day02::Play.for_result(opponent, result_code)
        expect(result).to be_a(Day02::Scissors)
      end
    end
  end

  describe "#part_one" do
    it "calculates the total score of all rounds given" do
      input = File.readlines("spec/test_inputs/02.txt", chomp: true)
      expect(Day02.part_one(input)).to eq(15)
    end
  end

  describe "#part_two" do
    it "calculates the summed calories from the 3 elves carrying the most calories" do
      input = File.readlines("spec/test_inputs/02.txt", chomp: true)
      expect(Day02.part_two(input)).to eq(12)
    end
  end
end
