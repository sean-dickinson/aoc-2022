module Day02
  class Play
    class UnrecognizedPlayError < StandardError; end
    class << self
      def from_user(character)
        {
          "X" => Rock,
          "Y" => Paper,
          "Z" => Scissors
        }.fetch(character).new
      end

      def for_result(opponent, result_code)
        options = [Rock, Paper, Scissors].map(&:new)
        desired_result = result_value(result_code)
        options.find do |choice|
          desired_result == (choice <=> opponent)
        end
      end

      def from_opponent(character)
        {
          "A" => Rock,
          "B" => Paper,
          "C" => Scissors
        }.fetch(character).new
      end

      private

      def result_value(code)
        {
          "X" => -1,
          "Y" => 0,
          "Z" => 1
        }.fetch(code)
      end
    end
  end

  class Rock < Play
    def score
      1
    end

    def <=>(other)
      {
        Rock => 0,
        Paper => -1,
        Scissors => 1
      }.fetch(other.class)
    end
  end

  class Paper < Play
    def score
      2
    end

    def <=>(other)
      {
        Rock => 1,
        Paper => 0,
        Scissors => -1
      }.fetch(other.class)
    end
  end

  class Scissors < Play
    def score
      3
    end

    def <=>(other)
      {
        Rock => -1,
        Paper => 1,
        Scissors => 0
      }.fetch(other.class)
    end
  end

  class Round
    attr_reader :user_play, :opponent_play
    def initialize(line, part_two: false)
      @opponent_play = get_opponent_play(line)
      @user_play = get_user_play(line, part_two)
    end

    def total_points
      user_play.score + outcome_points
    end

    def outcome
      {
        -1 => :loss,
        0 => :draw,
        1 => :win
      }.fetch(user_play <=> opponent_play)
    end

    private

    def outcome_points
      {
        loss: 0,
        draw: 3,
        win: 6
      }.fetch(outcome)
    end

    def get_opponent_play(line)
      character = line.split.first
      Play.from_opponent(character)
    end

    def get_user_play(line, part_two = false)
      character = line.split.last
      if part_two
        Play.for_result(opponent_play, character)
      else
        Play.from_user(character)
      end
    end
  end

  class << self
    def part_one(input)
      input.sum do |line|
        Round.new(line).total_points
      end
    end

    def part_two(input)
      input.sum do |line|
        Round.new(line, part_two: true).total_points
      end
    end
  end
end
