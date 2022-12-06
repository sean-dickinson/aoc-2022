module Day05
  class Stack
    attr_reader :list
    def initialize(list)
      @list = list
    end

    def push(other)
      list.unshift(other.list).flatten!
    end

    def peek
      list.first
    end

    def pop(n = 1)
      self.class.new(list.shift(n))
    end

    def to_s
      list.join("\n")
    end

    def ==(other)
      other.list == list
    end
  end

  class Stack::Group
    attr_reader :mapping
    def initialize(mapping)
      @mapping = mapping
    end

    def stacks
      mapping.values
    end

    def get(key)
      mapping[key]
    end

    def move(n, source, dest)
      dest_stack = get(dest)
      source_stack = get(source)
      n.times do
        dest_stack.push(source_stack.pop)
      end
    end
  end

  class Stack::Group2 < Stack::Group
    def move(n, source, dest)
      dest_stack = get(dest)
      source_stack = get(source)
      dest_stack.push(source_stack.pop(n))
    end
  end

  class Stack::Parser
    attr_reader :input
    def initialize(input)
      @input = input
    end

    def to_h
      mapping = empty_column_mapping

      remaining_lines.each do |line|
        column_to_index_map.each do |column, index|
          next if line[index] == " "
          stack = Stack.new([line[index]])
          mapping[column].push(stack)
        end
      end

      mapping
    end

    def empty_column_mapping
      column_to_index_map.transform_values { |v| Stack.new([]) }
    end

    def reversed_input
      input.reverse_each
    end

    def first_line
      reversed_input.first
    end

    def remaining_lines
      reversed_input.drop(1)
    end

    def column_to_index_map
      map = first_line.each_char.map(&:to_i).map.with_index.to_h
      map.delete(0)
      map
    end
  end

  class MoveParser
    def call(input)
      input.split.map(&:to_i).reject(&:zero?)
    end
  end

  class << self
    def part_one(input)
      stacks_input, moves_input = split_input(input)
      mapping = Stack::Parser.new(stacks_input).to_h

      group = Stack::Group.new(mapping)
      move_parser = MoveParser.new

      moves_input.each_with_index do |line, index|
        group.move(*move_parser.call(line))
      end

      group.stacks.map(&:peek).join
    end

    def part_two(input)
      stacks_input, moves_input = split_input(input)
      mapping = Stack::Parser.new(stacks_input).to_h

      group = Stack::Group2.new(mapping)
      move_parser = MoveParser.new

      moves_input.each_with_index do |line, index|
        group.move(*move_parser.call(line))
      end

      group.stacks.map(&:peek).join
    end

    private

    def split_input(input)
      stacks = input[0...blank_line_index(input)]
      moves = input[(blank_line_index(input) + 1)..]
      [stacks, moves]
    end

    def blank_line_index(input)
      input.find_index { |line| line == "" }
    end
  end
end
