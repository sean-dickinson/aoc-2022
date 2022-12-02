require "./01"

describe Day01 do
  describe "#part_one" do
    it "calculates the maximum summed calories from the inputs given" do
      input = File.readlines("spec/test_inputs/01.txt", chomp: true)
      expect(Day01.part_one(input)).to eq(24000)
    end
  end

  describe "#part_two" do
    it "calculates the summed calories from the 3 elves carrying the most calories" do
      input = File.readlines("spec/test_inputs/01.txt", chomp: true)
      expect(Day01.part_two(input)).to eq(45000)
    end
  end

  describe "Items" do
    describe "self.#from" do
      it "creates a list of items from raw input" do
        input = File.readlines("spec/test_inputs/01.txt", chomp: true)
        result = Day01::Items.from(input)

        expect(result).to be_a(Array)
        expect(result.size).to eq(5)
        expect(result).to all(be_an(Day01::Items))
      end
    end

    describe "#total" do
      it "calculates the sum of the items given" do
        list = [1000, 2000, 3000]
        items = Day01::Items.new(list)

        expect(items.total).to be(6000)
      end
    end
  end
end
