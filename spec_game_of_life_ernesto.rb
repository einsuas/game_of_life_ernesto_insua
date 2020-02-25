require 'rspec'
require_relative 'game_world.rb'
require_relative 'cell.rb'
require_relative 'game_of_life_ernesto_insua.rb'

describe 'Game of life Ernesto' do

  #Global variables
  let!(:game_world) { Game_World.new }
  let!(:game_of_life) { Game_of_life.new(game_world, [[1, 1]]) }
  let!(:cell) { Cell.new(1,1)}

  context 'Game_of_life' do

    subject { Game_of_life.new }
    it 'Create a new Game_World' do
      expect(subject.is_a?(Game_of_life)).to eq(true)
    end

    it 'Check if all properties and method exists' do
      expect(subject).to respond_to(:game_world)
      expect(subject).to respond_to(:initials_cells)
    end

    it 'Check all properties initialization' do
      expect(subject.game_world.is_a?(Game_World)).to eq(true)
      expect(subject.initials_cells.is_a?(Array)).to eq(true)
    end

    it 'Check initials_cells initialization' do
      game_of_life = Game_of_life.new(game_world, [[0, 1], [1, 1]])
      expect(game_of_life.game_world.cells_grid[0][1].alive).to eq(true)
      expect(game_of_life.game_world.cells_grid[1][1].alive).to eq(true)
    end

    it 'Check counts cells' do
      game_of_life = Game_of_life.new(game_world, [[0, 1], [1, 1], [2, 1]])
      expect(game_world.live_cells.count).to eq(3)
      expect(game_world.dead_cells.count).to eq(6)
    end
  end

  context 'Game_World' do

    subject { Game_World.new }
    it 'Create a new Game_World' do
      expect(subject.is_a?(Game_World)).to eq(true)
    end

    it 'Responds to created methods' do
      expect(subject).to respond_to(:columns)
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cells_grid)
      expect(subject).to respond_to(:cells)
      expect(subject).to respond_to(:live_neighbours_of_the_cell)
    end

    it 'Populate cells array' do
      #3x3
      expect(subject.cells.count).to eq(9)
      #Test that the inner elements are an array too
      subject.cells_grid.each do |row|
        expect(row.is_a?(Array)).to eq(true)
        row.each do |element|
          expect(element.is_a?(Cell)).to eq(true)
        end
      end
    end

    it 'Responds to created cells_grid array' do
      #Test that is an array
      expect(subject.cells_grid.is_a?(Array)).to eq(true)
      #Test that the inner elements are an array too
      subject.cells_grid.each do |row|
        expect(row.is_a?(Array)).to eq(true)
        row.each do |cell|
          expect(cell.is_a?(Cell)).to eq(true)
        end
      end
    end

    it 'Detects live neighbour Up' do
      subject.cells_grid[cell.y - 1][cell.x].alive = true
      expect(subject.live_neighbours_of_the_cell(cell).count).to eq(0)
    end
    it 'Detects live neighbour Right' do
      subject.cells_grid[cell.y][cell.x + 1].alive = true
      expect(subject.live_neighbours_of_the_cell(cell).count).to eq(0)
    end
    it 'Detects live neighbour Down' do
      subject.cells_grid[cell.y + 1][cell.x].alive = true
      expect(subject.live_neighbours_of_the_cell(cell).count).to eq(1)
    end
    it 'Detects live neighbour Left' do
      subject.cells_grid[cell.y][cell.x - 1].alive = true
      expect(subject.live_neighbours_of_the_cell(cell).count).to eq(1)
    end
    it 'Detects live neighbour Up-Right' do
      subject.cells_grid[cell.y - 1][cell.x + 1].alive = true
      expect(subject.live_neighbours_of_the_cell(cell).count).to eq(1)
    end
    it 'Detects live neighbour Down-Right' do
      subject.cells_grid[cell.y + 1][cell.x + 1].alive = true
      expect(subject.live_neighbours_of_the_cell(cell).count).to eq(1)
    end

    it 'Detects live neighbour Down-Left' do
      subject.cells_grid[cell.y + 1][cell.x - 1].alive = true
      expect(subject.live_neighbours_of_the_cell(cell).count).to eq(1)
    end
    it 'Detects live neighbour Up-Left' do
      subject.cells_grid[cell.y - 1][cell.x - 1].alive = true
      expect(subject.live_neighbours_of_the_cell(cell).count).to eq(1)
    end

  end

  context 'Cell' do

    subject { Cell.new }
    it 'Create a new Cell' do
      expect(subject.is_a?(Cell)).to eq(true)
    end

    it 'Check if all properties and method exists' do
      expect(subject).to respond_to(:x)
      expect(subject).to respond_to(:y)
      expect(subject).to respond_to(:alive?)
      expect(subject).to respond_to(:die!)
    end

    it 'Check initialization' do
      expect(subject.x).to eq(0)
      expect(subject.y).to eq(0)
      expect(subject.alive).to eq(false)
    end

  end



  context 'Game_Rules' do

    context '#1: Any living cell with fewer than two live neighbours dies, as if caused by underpopulation.' do
      it 'Kills live cell with 0 neighbour' do
          expect(game_of_life.game_world.cells_grid[1][1].alive).to eq(true)
        # ! in ruby changes the object permanently
          game_of_life.next_generation!
          expect(game_of_life.game_world.cells_grid[1][1].alive).to eq(false)
      end

      it 'Kills live cell with 1 live neighbour' do
        game_of_life = Game_of_life.new(game_world, [[0, 1], [1, 1]])
        game_of_life.next_generation!
        expect(game_of_life.game_world.cells_grid[0][1].alive).to eq(false)
        expect(game_of_life.game_world.cells_grid[1][1].alive).to eq(false)
      end

      it 'Dont kill live cell with 2 neighbours' do
        game_of_life = Game_of_life.new(game_world, [[0, 1], [1, 1], [2, 1]])
        game_of_life.next_generation!
        expect(game_of_life.game_world.cells_grid[1][1].alive).to eq(true)
      end
    end

    context '#2: Any live cell with more than three live neighbours dies, as if by overcrowding.' do
      it 'Should kill live cell with more than 3 live neighbours' do
        game_of_life = Game_of_life.new(game_world, [[0, 1], [1, 1], [2, 1], [2, 2], [1, 2]])
        expect(game_of_life.game_world.live_neighbours_of_the_cell(game_of_life.game_world.cells_grid[1][1]).count).to eq(4)
        game_of_life.next_generation!
        expect(game_of_life.game_world.cells_grid[0][1].alive).to eq(true)
        expect(game_of_life.game_world.cells_grid[1][1].alive).to eq(false)
        expect(game_of_life.game_world.cells_grid[2][1].alive).to eq(true)
        expect(game_of_life.game_world.cells_grid[2][2].alive).to eq(true)
        expect(game_of_life.game_world.cells_grid[1][2].alive).to eq(false)
      end
    end

    context '#3: Any live cell with two or three live neighbours lives on to the next generation.' do
      it 'Should keep alive cell with 2 neighbours to next generation' do
        game_of_life = Game_of_life.new(game_world, [[0, 1], [1, 1], [2, 1]])
        expect(game_of_life.game_world.live_neighbours_of_the_cell(game_of_life.game_world.cells_grid[1][1]).count).to eq(2)
        game_of_life.next_generation!
        expect(game_of_life.game_world.cells_grid[0][1].alive).to eq(false)
        expect(game_of_life.game_world.cells_grid[1][1].alive).to eq(true)
        expect(game_of_life.game_world.cells_grid[2][1].alive).to eq(false)
      end

      it 'Should keep alive cell with 3 neighbours to next generation' do
        game_of_life = Game_of_life.new(game_world, [[0, 1], [1, 1], [2, 1], [2, 2]])
        expect(game_of_life.game_world.live_neighbours_of_the_cell(game_of_life.game_world.cells_grid[1][1]).count).to eq(3)
        game_of_life.next_generation!
        expect(game_of_life.game_world.cells_grid[0][1].alive).to eq(false)
        expect(game_of_life.game_world.cells_grid[1][1].alive).to eq(true)
        expect(game_of_life.game_world.cells_grid[2][1].alive).to eq(true)
        expect(game_of_life.game_world.cells_grid[2][2].alive).to eq(true)
      end
    end



    context '#4: Any dead cell with exactly three live neighbours becomes a live cell.' do
      it 'Revives dead cell with 3 neighbours' do
        game_of_life = Game_of_life.new(game_world, [[0, 1], [1, 1], [2, 1]])
        expect(game_of_life.game_world.live_neighbours_of_the_cell(game_of_life.game_world.cells_grid[1][0]).count).to eq(3)
        game_of_life.next_generation!
        expect(game_of_life.game_world.cells_grid[1][0].alive).to eq(true)
        expect(game_of_life.game_world.cells_grid[1][2].alive).to eq(true)
      end
    end



  end


end