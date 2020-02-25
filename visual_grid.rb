require 'gosu'
require_relative 'game_world.rb'
require_relative 'game_of_life_ernesto_insua.rb'
class Visual_Grid < Gosu::Window

  def initialize(height=1000, width=1000)

    super height, width, false
    self.caption = "Game of Life test Ernesto Insua"
    @generation = 0
    #colors
    @background = Gosu::Color.new(0xffdedede)
    @alive = Gosu::Color.new(0xff121212)
    @dead = Gosu::Color.new(0xffededed)

    @rows = width/10
    @columns = height/10
    @world = Game_World.new(@rows, @columns)
    @game_of_life = Game_of_life.new(@world)
    @game_of_life.game_world.random_seed
    @row_height = height/@rows
    @column_width = width/@columns
    @generation = 0
  end

  def update
    @game_of_life.next_generation!
    @generation += 1
    puts "Generation: #{@generation}"
  end

  def draw
    draw_background
    @game_of_life.game_world.cells.each do |cell|
      cell_alive = cell.alive
      cell_x = cell.x
      cell_y = cell.y
      draw_quad(cell_x * @column_width, cell_y* @row_height, cell_alive ? @alive : @dead,
                cell_x * @column_width + (@column_width - 1), cell_y * @row_height, cell_alive ? @alive : @dead,
                cell_x * @column_width + (@column_width - 1), cell_y * @row_height + (@row_height - 1), cell_alive ? @alive : @dead,
                cell_x * @column_width, cell_y * @row_height + (@row_height - 1), cell_alive ? @alive : @dead)
    end
  end

  def draw_background
    draw_quad(0, 0, @background,
              width, 0, @background,
              width, height, @background,
              0, height, @background)
  end
end

Visual_Grid.new.show