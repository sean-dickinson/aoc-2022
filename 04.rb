module Day04
  class Assignment
    attr_reader :range
    def initialize(text)
      @range = parse_text(text)
    end

    def cover?(other)
      range.cover? other.range
    end

    def overlaps?(other)
      (range.to_a & other.range.to_a).size > 0
    end

    def ==(other)
      range == other.range
    end

    private

    def parse_text(text)
      start, stop = text.split("-").map(&:to_i)
      start..stop
    end
  end

  class Assignment::Pair
    class << self
      def from(line)
        assignment_1, assignment_2 = line.split(",").map { |t| Assignment.new(t) }
        new(assignment_1, assignment_2)
      end
    end

    attr_reader :assignment_1, :assignment_2
    def initialize(assignment_1, assignment_2)
      @assignment_1 = assignment_1
      @assignment_2 = assignment_2
    end

    def full_overlap?
      assignment_1.cover?(assignment_2) || assignment_2.cover?(assignment_1)
    end

    def any_overlap?
      assignment_1.overlaps? assignment_2
    end

    def ==(other)
      (assignment_1 == other.assignment_1 && assignment_2 == other.assignment_2) ||
        (assignment_1 == other.assignment_2 && assignment_2 == other.assignment_2)
    end
  end

  class << self
    def part_one(input)
      input.count do |line|
        Assignment::Pair.from(line).full_overlap?
      end
    end

    def part_two(input)
      input.count do |line|
        Assignment::Pair.from(line).any_overlap?
      end
    end
  end
end
