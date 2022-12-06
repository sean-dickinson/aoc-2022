require "./05"
describe Day05 do
  describe "Stack" do
    describe "#to_s" do
      it "outputs the stack as a string" do
        stack = Day05::Stack.new(["A", "B", "C"])
        expected_output = "A\nB\nC"
        expect(stack.to_s).to eq(expected_output)
      end
    end

    describe "#push" do
      it "pushes the items onto the current stack" do
        stack = Day05::Stack.new(["A", "B", "C"])
        other_stack = Day05::Stack.new(["Y", "Z"])

        expected_stack = Day05::Stack.new(["Y", "Z", "A", "B", "C"])

        stack.push(other_stack)

        expect(stack).to eq(expected_stack)
      end
    end

    describe "#pop" do
      it "removes an item from the top of the stack" do
        stack = Day05::Stack.new(["A", "B", "C"])
        expected_stack = Day05::Stack.new(["B", "C"])

        stack.pop
        expect(stack).to eq(expected_stack)
      end

      it "removes n number of items from the top of the stack" do
        stack = Day05::Stack.new(["A", "B", "C"])
        expected_stack = Day05::Stack.new(["C"])

        stack.pop(2)
        expect(stack).to eq(expected_stack)
      end

      it "returns the items removed as a new stack" do
        stack = Day05::Stack.new(["A", "B", "C"])
        expected_output = Day05::Stack.new(["A"])

        expect(stack.pop).to eq(expected_output)
      end
    end

    describe "#peek" do
      it "returns the top item from the stack without changing the stack" do
        stack = Day05::Stack.new(["A", "B", "C"])

        expect(stack.peek).to eq("A")
        expect(stack).to eq(Day05::Stack.new(["A", "B", "C"]))
      end
    end
  end

  describe "Stack::Parser" do
    describe "#to_h" do
      it "creates a hash of column names to stacks from the input" do
        input = File.readlines("spec/test_inputs/05/stacks_only.txt", chomp: true)
        parser = Day05::Stack::Parser.new(input)

        expected_hash = {
          1 => Day05::Stack.new(["N", "Z"]),
          2 => Day05::Stack.new(["D", "C", "M"]),
          3 => Day05::Stack.new(["P"])
        }

        expect(parser.to_h).to eq(expected_hash)
      end
    end
  end

  describe "Stack::Group" do
    describe "#get" do
      it "returns the stack at the given key" do
        mapping = {
          1 => Day05::Stack.new(["A", "B"]),
          2 => Day05::Stack.new(["C", "D"])
        }
        group = Day05::Stack::Group.new(mapping)

        expect(group.get(1)).to eq(mapping[1])
      end
    end

    describe "#move" do
      it "moves 1 of the crates from one stack to another" do
        mapping = {
          1 => Day05::Stack.new(["A", "B"]),
          2 => Day05::Stack.new(["C", "D"])
        }
        group = Day05::Stack::Group.new(mapping)

        group.move(1, 1, 2)

        expect(group.get(1)).to eq(Day05::Stack.new(["B"]))
        expect(group.get(2)).to eq(Day05::Stack.new(["A", "C", "D"]))
      end

      it "moves 3  crates from one stack to another" do
        mapping = {
          1 => Day05::Stack.new(["A", "B", "C"]),
          2 => Day05::Stack.new(["D"])
        }
        group = Day05::Stack::Group.new(mapping)

        group.move(3, 1, 2)

        expect(group.get(1)).to eq(Day05::Stack.new([]))
        expect(group.get(2)).to eq(Day05::Stack.new(["C", "B", "A", "D"]))
      end
    end
  end

  describe "MoveParser" do
    describe "#call" do
      it "parses the move command into an array of the 3 args" do
        input = "move 1 from 2 to 1"
        parser = Day05::MoveParser.new

        expect(parser.call(input)).to eq([1, 2, 1])
      end
    end
  end

  describe "#part_one" do
    it "calculates the crates at the top of each stack" do
      input = File.readlines("spec/test_inputs/05.txt", chomp: true)
      expect(Day05.part_one(input)).to eq("CMZ")
    end
  end

  describe "#part_two" do
    it "calculates the crates at the top of each stack" do
      input = File.readlines("spec/test_inputs/05.txt", chomp: true)
      expect(Day05.part_two(input)).to eq("MCD")
    end
  end
end
