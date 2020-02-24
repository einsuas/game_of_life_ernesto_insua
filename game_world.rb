class Game_World
  attr_accessor :columns, :rows, :cells_grid

  def initialize(columns = 10, rows = 10)

    @cols = columns
    @rows = rows
    @cells = []

    @cells_grid = Array.new(rows) do |row|
      Array.new(columns) do |column|
        Cell.new(column, row)
      end
    end

  end

end