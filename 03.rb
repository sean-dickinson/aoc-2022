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
    attr_reader :contents, :compartment_1, :compartment_2
    def initialize(input)
      @compartment_1, @compartment_2 = create_compartments(input)
      @contents = @compartment_1 + @compartment_2
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

  class RucksackGroup
    class << self
      def from(*lines)
        new(*lines.map { |line| Rucksack.new(line) })
      end
    end

    attr_reader :rucksacks
    def initialize(*rucksacks)
      @rucksacks = rucksacks
    end

    def common_item
      rucksacks.map(&:contents).reduce(&:&).first
    end
  end

  class << self
    def part_one(input)
      mapping = PriorityMapping.new
      input.sum do |sack|
        common_item = Rucksack.new(sack).common_item
        mapping.fetch(common_item)
      end
    end

    def part_two(input)
      mapping = PriorityMapping.new
      input.each_slice(3).sum do |lines|
        common_item = RucksackGroup.from(*lines).common_item
        mapping.fetch(common_item)
      end
    end
  end
end
