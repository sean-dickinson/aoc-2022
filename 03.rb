module Day03
  class PriorityMapping
    attr_reader :map
    def initialize
      set_map
    end

    def fetch(character)
      map.fetch(character, -1)
    end

    private

    def set_map
      @map = {}
      letters.each.with_index(1) do |letter, index|
        @map[letter] = index
      end
    end

    def letters
      ("a".."z").to_a + ("A".."Z").to_a
    end
  end

  class Rucksack
    attr_reader :compartment_1, :compartment_2
    def initialize(input)
      @compartment_1, @compartment_2 = create_compartments(input)
    end

    def common_item
      (compartment_1 & compartment_2).first
    end

    private

    def create_compartments(input)
      slice_string(input).map { |slice| slice.chars }
    end

    def slice_string(input)
      half = input.size / 2
      [input[0...half], input[half..]]
    end
  end

  class << self
    def part_one(input)
      raise NotImplementedError
    end

    def part_two(input)
      raise NotImplementedError
    end
  end
end
