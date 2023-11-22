# frozen_string_literal: true

require_relative 'game'
require_relative 'display'

# Starts game from main.rb
module GameStarter
  def start_game
    DisplayText.display_instructions
    puts "\nReady to play? (yes, no)"
    start
  end

  private

  def choose_mode
    puts "\nWhich one do you want to be? (guesser, creator)"
    mode = gets.chomp.downcase.strip
    unless %w[guesser creator].include?(mode)
      puts "\nChoose a valid gamemode."
      choose_mode
    end
    mode
  end

  def play?
    answer = gets.chomp.downcase.strip
    return play? unless %w[yes no].include?(answer)

    answer == 'yes'
  end

  def yes
    puts "\n_______________________________________________"
    puts "\nReady... Set... GO!"
    sleep(1)

    Game.new(choose_mode).play
  end

  def no
    puts "\n_______________________________________________"
    puts "\nIt's a shame, goodbye!"
    puts ''
    exit
  end

  def start
    if play?
      yes
    else
      no
    end
    sleep(2)
    puts "\n_______________________________________________"
    puts "\nWant to play again? (yes, no)"
    start
  end
end
