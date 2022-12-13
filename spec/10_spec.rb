require "./10"
describe Day10 do

  describe "Register" do 
    describe "#value" do 
      it "returns value of 1 for a new register" do
        expect(Day10::Register.new.value).to eq(1)
      end
    end

    describe "#noop" do 
      it "increments the cycle count" do
        register = Day10::Register.new

        expect {register.noop }.to change {register.cycle_count}.by(1)
      end

      it "does not change the value" do
        register = Day10::Register.new

        expect {register.noop }.not_to change {register.value}
      end
    end

    describe "#addx" do
      it "increments the cycle count by 2" do
        register = Day10::Register.new

        expect {register.addx(1) }.to change {register.cycle_count}.by(2)
      end

      it "adds x to the value" do
        register = Day10::Register.new

        expect {register.addx(1) }.to change {register.value}.by(1)
        expect {register.addx(-2) }.to change {register.value}.by(-2)
      end
    end
  end

  describe "Renderer" do
    describe "#pixel" do
      it "returns a '#' if the sprite covers the current position" do
        renderer = Day10::Renderer.new([
          1, # row 1 positon 0 Sprite is covering positions 0 1 2,
          1, # row 1 positon 1 Sprite is covering positions 0 1 2,
          *(3..40).to_a, # rest of row 1,
          1, # row 2 position 0 Sprite is covering positions 0 1 2,
          2 # row 2 position 1  Sprite is covering positions 1 2 3,
        ])

       expect(renderer.pixel(0, 0)).to eq("#")
       expect(renderer.pixel(0, 1)).to eq("#")
       expect(renderer.pixel(1, 1)).to eq("#")
      end

      it "returns a '.' if the sprite does not cover the current position" do
        renderer = Day10::Renderer.new([
            5, # Sprite is covering positions 4 5 6,
            10 # Sprite is covering positions 9 10 11
          ])

       expect(renderer.pixel(0, 0)).to eq(".")
       expect(renderer.pixel(0, 1)).to eq(".")
      end

    end
  end
  
  describe "#part_one" do
    it "sums the signal strengths during the specific cycles" do
      input = File.readlines("spec/test_inputs/10.txt", chomp: true)
      expect(Day10.part_one(input)).to eq(13140)
    end
  end

  describe "#part_two" do
    it "?" do
      input = File.readlines("spec/test_inputs/10.txt", chomp: true)
      expected_output = <<-TEXT

##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
TEXT
      expect(Day10.part_two(input)).to eq(expected_output)
    end
  end
end
