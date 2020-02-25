class Game_World
  attr_accessor :columns, :rows, :cells_grid, :cells

  def initialize(columns = 10, rows = 10)
    @columns = columns
    @rows = rows
    @cells = []

    @cells_grid = Array.new(rows) do |row|
      Array.new(columns) do |column|
        cell = Cell.new(column, row)
        cells << cell
        cell
      end
    end
  end

  # return the array of cells that are live neighbours of the actual cell
  def live_neighbours_of_the_cell(cell)
    live_neighbours = []

    # Neighbour to the Up
    if cell.y > 0
      cell_to_checking = self.cells_grid[cell.y - 1][cell.x]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbour to the Right
    if cell.x < (columns - 1)
      cell_to_checking = self.cells_grid[cell.y][cell.x + 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbour to the Down
    if cell.y < (rows - 1)
      cell_to_checking = self.cells_grid[cell.y + 1][cell.x]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbours to the Left
    if cell.x > 0
      cell_to_checking = self.cells_grid[cell.y][cell.x - 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbour to the Up-Right
    if cell.y > 0
      cell_to_checking = self.cells_grid[cell.y -1][cell.x]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbour to the Down-Right
    if cell.y < (rows - 1) and cell.x < (columns - 1)
      cell_to_checking = self.cells_grid[cell.y + 1][cell.x + 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbours to the Down-Left
    if cell.y < (rows - 1) and cell.x > 0
      cell_to_checking = self.cells_grid[cell.y + 1][cell.x - 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    # Neighbours to the Up-Left
    if cell.y > 0 and cell.x > 0
      cell_to_checking = self.cells_grid[cell.y - 1][cell.x - 1]
      live_neighbours << cell_to_checking if cell_to_checking.alive?
    end
    live_neighbours
  end

end