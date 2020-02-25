#Main file of the game

class Game_of_life

  attr_accessor :game_world
  def initialize(game_world = Game_World.new, initials_cells = [])
    @game_world = game_world
    @initials_cells = initials_cells

    initials_cells.each do |cells|
      printf(cells)
      game_world.cells_grid[cells[0]][cells[1]].alive = true
    end
  end

  def next_generation!
    next_generation_live_cells = []
    next_generation_dead_cells = []

    @game_world.cells.each do |cell|
      neighbour_count = self.game_world.live_neighbours_of_the_cell(cell).count

      #1: Any living cell with fewer than two live neighbours dies, as if caused by underpopulation.
      if cell.alive? && neighbour_count < 2
        next_generation_dead_cells << cell
      end

      #2: Any live cell with more than three live neighbours dies, as if by overcrowding.
      if cell.alive? && neighbour_count > 3
        next_generation_dead_cells << cell
      end

      #3: Any live cell with two or three live neighbours lives on to the next generation.
      if cell.alive? && ([2, 3].include? neighbour_count)
        next_generation_live_cells << cell
      end

      #4: Any dead cell with exactly three live neighbours becomes a live cell.
      if cell.dead? && neighbour_count == 3
        next_generation_live_cells << cell
      end
    end

    next_generation_live_cells.each do |cell|
      cell.reborn!
    end
    next_generation_dead_cells.each do |cell|
      cell.die!
    end
  end

end



