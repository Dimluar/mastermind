# frozen_string_literal: true

# Game's computer player
class Computer
  def set_code
    code = []
    4.times do
      code.push(rand(1..6))
    end
    code
  end

  def guess_code; end
end
