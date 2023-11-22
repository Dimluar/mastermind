# frozen_string_literal: true

require_relative 'code_tester'

# Game's computer player
class Computer
  include CodeTest

  def set_code
    code = []
    4.times do
      code.push(rand(1..6))
    end
    code
  end

  def guess_code(options, last_guess, clues)
    return first_option if options.empty?

    series = options.filter do |option|
      test = compare_result(last_guess, option)
      clues == test
    end
    [series, series[rand(0...series.length)]]
  end

  private

  def first_option
    options = [*1..6].repeated_permutation(4).to_a
    [options, options[rand(0...options.length)]]
  end
end
