# frozen_string_literal: true

# Game's human player
class Player
  attr_accessor :mode

  def initialize(gamemode = 'guesser')
    @mode = gamemode
  end

  def set_code
    puts "\nWhat code should be guessed?"
    input_code
  end

  def guess_code
    puts "\nMake your guess:"
    input_code
  end

  private

  def valid_code?(arr)
    arr.all? { |number| (1..6).include?(number) } && arr.length == 4
  end

  def input_code
    code = []
    loop do
      code = gets.chomp.split('').map(&:to_i)
      break if valid_code?(code)

      puts "\nIntroduce a valid code."
    end
    code
  end
end
