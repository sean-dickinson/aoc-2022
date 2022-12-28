require "./11"
describe Day11 do
  describe Day11::Monkey do
    describe "#inspect" do
      it "applies the #operation to the value given" do
        monkey = Day11::Monkey.new
        item = 1
        expect(monkey).to receive(:operation).with(item)

        monkey.inspect(item)
      end
    end

    describe "#throw" do
      it "calls #receive on a receiver" do
        receiving_monkey_1 = double
        item = 1
        expect(receiving_monkey_1).to receive(:receive).with(item)
        monkey = Day11::Monkey.new

        monkey.throw_to(receiving_monkey_1, item)
      end
    end

    describe "#turn" do
      it "throws all items" do
        monkey = Day11::Monkey.new([1, 2, 3])
        receiving_monkey_1 = double
        receiving_monkey_2 = double
        expect(receiving_monkey_1).to receive(:receive).exactly(3).times
        monkey.receivers = [receiving_monkey_1, receiving_monkey_2]
        expect { monkey.turn }.to change { monkey.items }.from([1, 2, 3]).to([])
      end
    end

    describe "subclassing Monkey" do
      it "allows an override to #operation" do
        operation = ->(old) { old + 1 }
        addition_monkey_class = Class.new(Day11::Monkey) do
          private

          define_method(:operation, operation)
        end

        addition_monkey = addition_monkey_class.new

        expect(addition_monkey.inspect(1)).to eq(2)
      end
    end
    describe "self.gcm" do
      it "finds the greatest common multiple of all monkey subclasses" do
        Day11::Monkey.reset_descendants
        divisors = [2, 3, 5]
        divisors.each do |d|
          Class.new(Day11::Monkey) do
            define_method(:divisor, -> { d })
          end.new
        end

        expect(Day11::Monkey.gcm).to eq(2 * 3 * 5)
      end
    end
  end

  describe Day11::MonkeyFactory do
    describe "#self.create_monkey" do
      it "creates a new class that inherits from Monkey and returns an instance of that class" do
        input = [
          "Monkey 0:",
          "Starting items: 79, 98",
          "Operation: new = old * 19",
          "Test: divisible by 23",
          "If true: throw to monkey 2",
          "If false: throw to monkey 3"
        ]

        monkey_01 = Day11::MonkeyFactory.create_monkey(input, 0)
        expect(monkey_01.class.ancestors).to include(Day11::Monkey)
        expect(monkey_01).not_to be_instance_of(Day11::Monkey)
      end
    end

    describe "#self.get_receivers" do
      it "finds the correct recievers from the input" do
        input = [
          "Monkey 0:",
          "Starting items: 79, 98",
          "Operation: new = old * 19",
          "Test: divisible by 23",
          "If true: throw to monkey 2",
          "If false: throw to monkey 3"
        ]
        monkeys = [0, 1, 2, 3, 4, 5]

        expect(Day11::MonkeyFactory.get_receivers(monkeys, input)).to eq([2, 3])
      end
    end
  end

  describe Day11::InputChunker do
    describe "#chunks" do
      it "groups inputs together separated by the empty lines" do
        input = [
          "a",
          "b",
          "c",
          "",
          "d",
          "e",
          "f"
        ]
        expected_output = [
          ["a", "b", "c"],
          ["d", "e", "f"]
        ]
        chunker = Day11::InputChunker.new(input)

        expect(chunker.chunks.to_a).to eq(expected_output)
      end
    end
  end

  describe "#part_one" do
    it "calculates the monkey business after 20 rounds" do
      input = File.readlines("spec/test_inputs/11.txt", chomp: true)
      expect(Day11.part_one(input)).to eq(10605)
    end
  end

  describe "#part_two" do
    it "calculates the monkey business after 10000 rounds with no worry decreasing" do
      input = File.readlines("spec/test_inputs/11.txt", chomp: true)
      expect(Day11.part_two(input)).to eq(2713310158)
    end
  end
end
