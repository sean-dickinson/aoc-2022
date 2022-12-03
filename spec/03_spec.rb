require "./03"
describe Day03 do
  describe "PriorityMapping" do
    describe "#fetch" do
      it "returns the correct priority for each lowercase letter" do
        mapping = Day03::PriorityMapping.new
        expect(mapping.fetch("a")).to eq(1)
        expect(mapping.fetch("d")).to eq(4)
        expect(mapping.fetch("z")).to eq(26)
      end
      it "returns the correct priority for each uppercase letter" do
        mapping = Day03::PriorityMapping.new
        expect(mapping.fetch("A")).to eq(27)
        expect(mapping.fetch("L")).to eq(38)
        expect(mapping.fetch("Z")).to eq(52)
      end
    end
  end

  describe "Rucksack" do
    describe "#common_item" do
      it "returns the common item between the 2 compartments" do
        input = "vJrwpWtwJgWrhcsFMMfFFhFp"
        rucksack = Day03::Rucksack.new(input)
        expect(rucksack.common_item).to eq("p")
      end
    end
  end

  describe "RucksackGroup" do
    describe "#common_item" do
      it "returns the common item between all Rucksacks" do
        input_1 = "abcd"
        input_2 = "aBCD"
        group = Day03::RucksackGroup.from(input_1, input_2)
        expect(group.common_item).to eq("a")
      end
    end
  end

  describe "#part_one" do
    it "calculates the sum of all priorities of the common item types" do
      input = File.readlines("spec/test_inputs/03.txt", chomp: true)
      expect(Day03.part_one(input)).to eq(157)
    end
  end

  describe "#part_two" do
    it "calculates the sum of all priorities of the common items from each group of 3 rucksacks" do
      input = File.readlines("spec/test_inputs/03.txt", chomp: true)
      expect(Day03.part_two(input)).to eq(70)
    end
  end
end
