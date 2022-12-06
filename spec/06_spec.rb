require "./06"
describe Day06 do
  describe "Buffer" do
    describe "#start_index" do
      it "returns the index of the character of the start of the packet with a default size of 4" do
        [
          ["mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7],
          ["bvwbjplbgvbhsrlpgdmjqwftvncz", 5],
          ["nppdvjthqldpwncqszvftbrmjlhg", 6],
          ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10],
          ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11]
        ].each do |input, expected_index|
          buffer = Day06::Buffer.new(input)

          expect(buffer.start_index).to eq(expected_index)
        end
      end
      it "returns the index of the character with an arbitrary window size" do
        [
          ["mjqjpqmgbljsphdztnvjfqwrcgsmlb", 19],
          ["bvwbjplbgvbhsrlpgdmjqwftvncz", 23],
          ["nppdvjthqldpwncqszvftbrmjlhg", 23],
          ["nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 29],
          ["zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 26]
        ].each do |input, expected_index|
          buffer = Day06::Buffer.new(input, 14)

          expect(buffer.start_index).to eq(expected_index)
        end
      end
    end
  end
  describe "#part_one" do
    it "finds the index of the start of the packet" do
      input = File.readlines("spec/test_inputs/06.txt", chomp: true)
      expect(Day06.part_one(input)).to eq(7)
    end
  end

  describe "#finds the index of the start of the message" do
    it "?" do
      input = File.readlines("spec/test_inputs/06.txt", chomp: true)
      expect(Day06.part_two(input)).to eq(19)
    end
  end
end
