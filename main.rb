# frozen_string_literal: true

require_relative 'game'

def init_game
  Game.new.play
end

def play?
  answer = gets.chomp.downcase.strip
  return play? unless %w[yes no].include?(answer)

  answer == 'yes'
end

def yes
  puts "\n_______________________________________________"
  puts "\nReady... Set... GO!"
  init_game
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

Game.new.display_instructions
puts "\nReady to play? (yes, no)"
start
