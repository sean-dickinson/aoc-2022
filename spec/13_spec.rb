require "./13"
describe Day13 do
  describe "#part_one" do
    it "finds sum of all the indicies of packet pairs that are in the right order" do
      skip
      input = File.readlines("spec/test_inputs/13.txt", chomp: true)
      expect(Day13.part_one(input)).to eq(13)
    end
  end
end
