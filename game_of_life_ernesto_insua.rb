#Main file of the game

class Game_of_life

  attr_accessor :game_world, :initials_cells
  def initialize(game_world = Game_World.new, initials_cells = [])
    @game_world = game_world
    @initials_cells = initials_cells
  end

end



