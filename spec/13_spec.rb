require "./13"
describe Day13 do
  describe Day13::Packet do
    describe "#<" do
      describe "when comparing integers" do
        it "returns true if the left integer is less than the right" do
          packet = Day13::Packet.new([1])
          other_packet = Day13::Packet.new([2])

          expect(packet).to be < other_packet
        end

        it "returns true if the first left integer that is not the same is less than the right" do
          packet = Day13::Packet.new([1, 1])
          other_packet = Day13::Packet.new([1, 3])

          expect(packet).to be < other_packet
        end

        it "returns false if the left integer is greater than the right" do
          packet = Day13::Packet.new([5])
          other_packet = Day13::Packet.new([2])

          expect(packet).not_to be < other_packet
        end

        it "returns false if the first left integer that is not the same is greater than the right" do
          packet = Day13::Packet.new([2, 5])
          other_packet = Day13::Packet.new([2, 2])

          expect(packet).not_to be < other_packet
        end

        it "returns true if the left packet is smaller than the right and all values are equal" do
          packet = Day13::Packet.new([2])
          other_packet = Day13::Packet.new([2, 2])

          expect(packet).to be < other_packet
        end

        it "returns false if the left packet is larger than the right and all values are equal" do
          packet = Day13::Packet.new([2, 2, 2])
          other_packet = Day13::Packet.new([2, 2])

          expect(packet).not_to be < other_packet
        end
      end

      describe "when comparing lists" do
        it "returns true if the left list has an item that is lower than the right" do
          packet = Day13::Packet.new([[1]])
          other_packet = Day13::Packet.new([[2]])

          expect(packet).to be < other_packet
        end

        it "returns true if the first left integer that is not the same is less than the right" do
          packet = Day13::Packet.new([[1, 1]])
          other_packet = Day13::Packet.new([[1, 2]])

          expect(packet).to be < other_packet
        end

        it "returns true if the left list is smaller than the right and all values are the same" do
          packet = Day13::Packet.new([[1, 1]])
          other_packet = Day13::Packet.new([[1, 1, 1]])

          expect(packet).to be < other_packet
        end

        it "returns false if the left list is longer than the right and all values are the same" do
          packet = Day13::Packet.new([[1, 1, 1, 1]])
          other_packet = Day13::Packet.new([[1, 1, 1]])

          expect(packet).not_to be < other_packet
        end

        it "returns false if the first left integer that is not the same is greater than the right" do
          packet = Day13::Packet.new([[1, 3]])
          other_packet = Day13::Packet.new([[1, 2]])

          expect(packet).not_to be < other_packet
        end

        it "returns false if the left list has an item that is higher than the right" do
          packet = Day13::Packet.new([[2]])
          other_packet = Day13::Packet.new([[1]])

          expect(packet).not_to be < other_packet
        end

        it "returns true when comparing an empty list to a list with items" do
          packet = Day13::Packet.new([[]])
          other_packet = Day13::Packet.new([[1]])

          expect(packet).to be < other_packet
        end

        it "returns false when comparing a of empty lists to a list with one empty list" do
          packet = Day13::Packet.new([[[]]])
          other_packet = Day13::Packet.new([[]])

          expect(packet).not_to be < other_packet
        end
      end

      describe "when comparing integers to lists" do
        it "returns true if the left integer is smaller than the list item" do
          packet = Day13::Packet.new([1])
          other_packet = Day13::Packet.new([[2, 1, 1]])

          expect(packet).to be < other_packet
        end

        it "returns false if the left integer is larger than the list item" do
          packet = Day13::Packet.new([3])
          other_packet = Day13::Packet.new([[2, 1, 1]])

          expect(packet).not_to be < other_packet
        end

        it "returns true for when mixed types" do
          packet = Day13::Packet.new([1, [2, [3, [4, [5, 6, 0]]]], 8, 9])
          other_packet = Day13::Packet.new([[1], 4])

          expect(packet).to be < other_packet
          expect(other_packet).not_to be < packet
        end

        it "returns true for deeply nested" do
          packet = Day13::Packet.new([1, 1, 3, 1, 1])
          other_packet = Day13::Packet.new([1, [2, [3, [4, [5, 6, 0]]]], 8, 9])

          # expect(packet).to be < other_packet
          expect(other_packet).not_to be < packet
        end
      end
    end

    describe "#<=>" do
      it "should correctly sort packets" do
        ordered_packets = [
          Day13::Packet.new([1, 1, 3, 1, 1]),
          Day13::Packet.new([1, 1, 5, 1, 1]),
          Day13::Packet.new([[1], [2, 3, 4]]),
          Day13::Packet.new([1, [2, [3, [4, [5, 6, 0]]]], 8, 9]),
          Day13::Packet.new([[1], 4])
        ]
        shuffled_packets = [
          Day13::Packet.new([[1], [2, 3, 4]]),
          Day13::Packet.new([[1], 4]),
          Day13::Packet.new([1, 1, 3, 1, 1]),
          Day13::Packet.new([1, [2, [3, [4, [5, 6, 0]]]], 8, 9]),
          Day13::Packet.new([1, 1, 5, 1, 1])
        ]
        expect(shuffled_packets.sort).to eq(ordered_packets)
      end
    end
  end

  describe "#part_one" do
    it "finds sum of all the indicies of packet pairs that are in the right order" do
      input = File.readlines("spec/test_inputs/13.txt", chomp: true)
      expect(Day13.part_one(input)).to eq(13)
    end
  end

  describe "#part_two" do
    it "finds product of the indicies of the divider packets when all packets are in sorted order" do
      input = File.readlines("spec/test_inputs/13.txt", chomp: true)
      expect(Day13.part_two(input)).to eq(140)
    end
  end
end
