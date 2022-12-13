require "./09"
describe Day09 do
  describe "Rope" do
    describe "#move" do
      it "calls the correct methods on the head and tail the correct number of times" do
        head_double = double("head")
        tail_double = double("end")

        expect(head_double).to receive(:move).with(:x, 1).exactly(4).times
        expect(tail_double).to receive(:follow).with(head_double).exactly(4).times
        allow(Day09::Rope::Knot).to receive(:new).and_return(head_double)
        allow(Day09::Rope::Tail).to receive(:new).and_return(tail_double)

        rope = Day09::Rope.new(0, 0)
        rope.move("R", 4)
      end
    end

    describe "#tail_position_count" do
      it "returns the unique number of tail positions" do
        head_double = double("head")
        tail_double = double("end")

        fake_positions = [
          [0, 0],
          [1, 0],
          [1, 1],
          [1, 1]
        ]

        expect(tail_double).to receive(:positions).and_return(fake_positions)
        allow(Day09::Rope::Knot).to receive(:new).and_return(head_double)
        allow(Day09::Rope::Tail).to receive(:new).and_return(tail_double)

        rope = Day09::Rope.new(0, 0)
        expect(rope.tail_position_count).to eq(3)
      end
    end
  end

  describe "Rope::Knot" do
    describe "#move" do
      it "increments the axis given by the amount given" do
        rope_end = Day09::Rope::Knot.new(0, 1)

        expect { rope_end.move(:x, 1) }.to change { rope_end.x }.from(0).to(1)
        expect { rope_end.move(:y, -1) }.to change { rope_end.y }.from(1).to(0)
      end
    end

    describe "#follow" do
      it "does not change the position if the other knot is only 1 step away" do
        rope_head = Day09::Rope::Knot.new(0, 1)
        rope_tail = Day09::Rope::Tail.new(0, 0)

        expect { rope_tail.follow(rope_head) }.not_to change { rope_tail.pos }
      end

      it "moves the position to follow the other along the x axis" do
        rope_head = Day09::Rope::Knot.new(0, 2)
        rope_tail = Day09::Rope::Tail.new(0, 0)

        expect { rope_tail.follow(rope_head) }.to change { rope_tail.pos }.from([0, 0]).to([0, 1])
      end

      it "moves the position to follow the other along the y axis" do
        rope_head = Day09::Rope::Knot.new(3, 3)
        rope_tail = Day09::Rope::Tail.new(3, 1)

        expect { rope_tail.follow(rope_head) }.to change { rope_tail.pos }.from([3, 1]).to([3, 2])
      end

      it "moves the position diagonally to follow when necessary" do
        rope_head = Day09::Rope::Knot.new(1, 2)
        rope_tail = Day09::Rope::Tail.new(0, 0)

        expect { rope_tail.follow(rope_head) }.to change { rope_tail.pos }.from([0, 0]).to([1, 1])
      end

      it "adds the new position to the positions list" do
        rope_head = Day09::Rope::Knot.new(1, 2)
        rope_tail = Day09::Rope::Tail.new(0, 0)

        expect { rope_tail.follow(rope_head) }.to change { rope_tail.positions.size }.from(1).to(2)
      end
    end
  end

  describe "#part_one" do
    it "counts the number of unique tail positions" do
      input = File.readlines("spec/test_inputs/09/part_1.txt", chomp: true)
      expect(Day09.part_one(input)).to eq(13)
    end
  end

  describe "#part_two" do
    it "counts the number of unique tail positions" do
      input = File.readlines("spec/test_inputs/09/part_2.txt", chomp: true)
      expect(Day09.part_two(input)).to eq(36)
    end
  end
end
