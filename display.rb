# frozen_string_literal: true

# Display how to play the game.
module DisplayText
  COLOR_KEYS = {
    1 => "\e[101m 1 \e[0m",
    2 => "\e[102m 2 \e[0m",
    3 => "\e[103m 3 \e[0m",
    4 => "\e[104m 4 \e[0m",
    5 => "\e[105m 5 \e[0m",
    6 => "\e[106m 6 \e[0m",
    'o' => "\e[41m   \e[0m",
    'x' => "\e[107m   \e[0m"
  }.freeze

  def get_colored_code(code_array)
    code_string = "\n"
    code_array.each { |value| code_string += COLOR_KEYS[value] }
    code_string
  end

  def get_colored_clues(code_string, clues)
    code_string += '  '
    clues[0].times { code_string += "#{COLOR_KEYS['o']} " }
    clues[1].times { code_string += "#{COLOR_KEYS['x']} " }
    code_string
  end

  def get_colored_round(code_array, clues)
    code_string = get_colored_code(code_array)
    get_colored_clues(code_string, clues)
  end

  def display_colored_round(code_array, clues)
    puts get_colored_round(code_array, clues)
  end

  def display_winner(player, winner, code)
    puts '---------------------------------------------------'
    puts "\nAnswer: #{get_colored_code(code)}"
    puts get_winner_text(player, winner)
  end

  INSTRUCTIONS = <<~TEXT

    WELCOME TO MASTERMIND
    _______________________________________________

    -GUESSER:

    In this game you will have to try to guess a code created by the computer. Each game will have 12 rounds (or tries), for you to do it.

    A code is 4 digits long with each one ranging from 1 to 6. Numbers can be repeated and blanck values are not permited.

    After each try, next to your code, clues will be displayed:
    - \e[41m   \e[0m: Correct number and position.
    - \e[107m   \e[0m: Correct number in wrong position.

    The clues can go from 0 to 4 and they do not tell you which number they correspond to.

    As an example output:
    "1234" + enter -> \e[101m 1 \e[102m 2 \e[103m 3 \e[104m 4 \e[0m \e[41m   \e[0m \e[41m   \e[0m \e[107m   \e[0m

    -CREATOR:

    This time you will be the one creating the code, with the above guidelines.

    After selecting your code the computer it's going to try to guess it.
    _______________________________________________

  TEXT

  def self.display_instructions
    puts INSTRUCTIONS
  end

  private

  def get_winner_text(player, winner)
    if player.mode == 'guesser'
      winner_guesser(winner)
    else
      winner_creator(winner)
    end
  end

  def winner_guesser(winner)
    winner == 'guesser' ? "\nCONGRATULATIONS YOU DID IT!" : "\nOH, BETTER LUCK NEXT TIME!"
  end

  def winner_creator(winner)
    winner == 'guesser' ? "\nUPS, SEEMS LIKE THE COMPUTER GUESSED IT!" : "\nTHAT'S UNEXPECTED! GOOD JOB!"
  end
end
