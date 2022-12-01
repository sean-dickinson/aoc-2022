require './01'

describe Day01 do
  describe "#part_one" do
    it "calculates the maximum summed calories from the inputs given" do
      input = File.readlines('spec/test_inputs/01.txt', chomp: true)
      expect(Day01::part_one(input)).to eq(24000)
    end
  end

  describe "#part_two" do
    it "calculates the summed calories from the 3 elves carrying the most calories" do
      input = File.readlines('spec/test_inputs/01.txt', chomp: true)
      expect(Day01::part_two(input)).to eq(45000)
    end
  end
end