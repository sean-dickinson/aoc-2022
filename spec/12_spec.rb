require "./12"
describe Day12 do
  describe "#part_one" do
    it "finds the number of steps in the shortest path" do
      input = File.readlines("spec/test_inputs/12.txt", chomp: true)
      expect(Day12.part_one(input)).to eq(31)
    end
  end

  describe "#part_two" do
    it "?" do
      skip
      input = File.readlines("spec/test_inputs/12.txt", chomp: true)
    end
  end
end
