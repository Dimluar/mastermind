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
end
