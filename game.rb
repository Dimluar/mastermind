# frozen_string_literal: true

require_relative 'display'
require_relative 'player'
require_relative 'computer'
require_relative 'code_tester'

# Game foundations
class Game
  include DisplayText
  include CodeTest

  def initialize(mode)
    @player = Player.new(mode)
    @computer = Computer.new
    @rounds = 12
    @code = set_creator_code
    @series = []
  end

  def play
    round = rounds
    clues = [0, 0]
    while round.positive?
      puts "\nTries: #{round}"
      clues = play_round(clues)
      round -= 1
      test_game_over(clues, round)
      break unless winner.nil?
    end

    display_winner(player, winner, code)
  end

  private

  attr_reader :code, :rounds, :winner, :guesser_code, :player, :computer

  def set_creator_code
    if player.mode == 'guesser'
      computer.set_code
    else
      player.set_code
    end
  end

  def get_guesser_code(clues)
    if player.mode == 'guesser'
      @guesser_code = player.guess_code
    else
      @series, @guesser_code = computer.guess_code(@series, @guesser_code, clues)
    end
  end

  def play_round(clues)
    get_guesser_code(clues)
    clues = compare_result(code, guesser_code)
    display_colored_round(guesser_code, clues)
    clues
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
