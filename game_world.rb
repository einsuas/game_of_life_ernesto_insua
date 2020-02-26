require_relative 'cell.rb'
# The Game_World class is used for the representation of the World in the game
class Game_World
  attr_accessor :columns, :rows, :cells_grid, :cells

  def initialize(rows = 3, columns = 3)
    @columns = columns
    @rows = rows
    @cells = []

    @cells_grid = Array.new(rows) do |row|
      Array.new(columns) do |column|
        Cell.new(column, row)
      end
    end

    @cells_grid.each do |row|
      row.each do |cell|
          cells << cell
      end
    end
  end

  def live_cells
    cells.select { |cell| cell.alive }
  end

  def dead_cells
    cells.select { |cell| cell.alive == false }
  end

  # return the array of cells that are live neighbours of the actual cell
  def live_neighbours_of_the_cell(cell_to_analyze)
    live_neighbours = []

    # Neighbour to the Up-Right
    if cell_to_analyze.y > 0 and cell_to_analyze.x < (columns - 1)
      cell_to_checking = self.cells_grid[cell_to_analyze.y - 1][cell_to_analyze.x + 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbour to the Down-Right
    if cell_to_analyze.y < (rows - 1) and cell_to_analyze.x < (columns - 1)
      cell_to_checking = self.cells_grid[cell_to_analyze.y + 1][cell_to_analyze.x + 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbours to the Down-Left
    if cell_to_analyze.y < (rows - 1) and cell_to_analyze.x > 0
      cell_to_checking = self.cells_grid[cell_to_analyze.y + 1][cell_to_analyze.x - 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbours to the Up-Left
    if cell_to_analyze.y > 0 and cell_to_analyze.x > 0
      cell_to_checking = self.cells_grid[cell_to_analyze.y - 1][cell_to_analyze.x - 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbour to the Up
    if cell_to_analyze.y > 0
      cell_to_checking = self.cells_grid[cell_to_analyze.y - 1][cell_to_analyze.x]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbour to the Right
    if cell_to_analyze.x < (columns - 1)
      cell_to_checking = self.cells_grid[cell_to_analyze.y][cell_to_analyze.x + 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbour to the Down
    if cell_to_analyze.y < (rows - 1)
      cell_to_checking = self.cells_grid[cell_to_analyze.y + 1][cell_to_analyze.x]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbours to the Left
    if cell_to_analyze.x > 0
      cell_to_checking = self.cells_grid[cell_to_analyze.y][cell_to_analyze.x - 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    live_neighbours
  end

  def random_seed
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
  end

end