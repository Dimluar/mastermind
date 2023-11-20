# frozen_string_literal: true

# Game's human player
class Player
  attr_accessor :mode

  def initialize(gamemode)
    @mode = gamemode
  end
end
