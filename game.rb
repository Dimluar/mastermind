# frozen_string_literal: true

require_relative 'display'
require_relative 'player'
require_relative 'computer'

# Game foundations
class Game
  include DisplayText

  def initialize
    @player = Player.new
    @computer = Computer.new
    @rounds = 12
    @code = set_creator_code
  end

  def play
    round = rounds
    while round.positive?
      puts "\nTries: #{round}"
      clues = play_round
      round -= 1
      test_game_over(clues, round)
      break unless winner.nil?
    end

    display_winner(winner, code)
  end

  private

  attr_reader :code, :rounds, :winner, :guesser_code, :player, :computer

  def set_creator_code
    computer.set_code if player.mode == 'guesser'
  end

  def set_guesser_code
    player.guess_code if player.mode == 'guesser'
  end

  def play_round
    @guesser_code = set_guesser_code
    clues = [0, 0]
    round_guessed = []
    clues, round_guessed = count_correct_guesses(clues, round_guessed)
    clues = count_included_numbers(clues, round_guessed)
    display_colored_round(guesser_code, clues)
    clues
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
    numbers_counted = [*round_guessed]
    guesser_code.zip(round_guessed).each do |value, guessed|
      clues[1] += 1 if !number_treated?(numbers_counted, code, value) && code.include?(value) && value != guessed
      numbers_counted.push(value) unless number_treated?(numbers_counted, code, value)
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
    @winner = 'creator' if round.zero?
    @winner = 'guesser' if clues[0] == 4
  end

  def test_game_over(clues, round)
    return unless game_over?(clues, round)

    get_winner(clues, round)
  end
end

Game.new.play
