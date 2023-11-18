# frozen_string_literal: true

# Game foundations
class Game
  def initialize
    @rounds = 12
    @code = set_code
  end

  def play
    round = rounds
    while round.positive?
      puts "\nTries: #{round}"

      clues = play_round

      p clues

      round -= 1

      test_game_over(clues, round)
      break unless winner.nil?
    end

    p code, winner
  end

  private

  attr_reader :code, :rounds, :winner
  attr_accessor :guesser_code

  def set_code
    code = []
    4.times do
      code.push(rand(1..6))
    end
    code
  end

  def guess_code
    loop do
      @guesser_code = gets.chomp.split('').map(&:to_i)
      break if valid_code?

      puts "\nIntroduce a valid code."
    end
  end

  def valid_code?
    guesser_code.all? { |number| (1..6).include?(number) } && guesser_code.length == 4
  end

  def play_round
    guess_code
    clues = [0, 0]
    round_guessed = []
    clues, round_guessed = count_correct_guesses(clues, round_guessed)
    count_included_numbers(clues, round_guessed)
  end

  def count_correct_guesses(clues, round_guessed)
    guesser_code.each.with_index do |value, index|
      if value == code[index]
        clues[0] += 1
        round_guessed.push(value)
      else
        round_guessed.push(0)
      end
    end
    [clues, round_guessed]
  end

  def count_included_numbers(clues, round_guessed)
    numbers_counted = []
    guesser_code.zip(round_guessed).each do |value, guessed|
      clues[1] += 1 if number_treated?(guesser_code, code, value) && code.include?(value) && value != guessed
      numbers_counted.push(value) unless number_treated?(guesser_code, code, value)
    end
    clues
  end

  def number_treated?(var1, var2, number)
    var1.tally[number] == var2.tally[number]
  end

  def game_over?(clues, round)
    clues[0] == 4 || round.zero? ? true : false
  end

  def get_winner(clues, round)
    @winner = 'guesser' if clues[0] == 4
    @winner = 'creator' if round.zero?
  end

  def test_game_over(clues, round)
    return unless game_over?(clues, round)

    get_winner(clues, round)
  end
end

game = Game.new
game.play
