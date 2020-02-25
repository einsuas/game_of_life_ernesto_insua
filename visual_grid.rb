require 'gosu'
require_relative 'game_world.rb'
require_relative 'game_of_life_ernesto_insua.rb'
class Visual_Grid < Gosu::Window

  def initialize(height=1000, width=1000)

    @height = height
    @width = width
    super height, width, false
    self.caption = "Game of Life test Ernesto Insua"
    @generation = 0
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
      if cell.alive?
        draw_quad(cell.x * @column_width, cell.y * @row_height, @alive,
                  cell.x * @column_width + (@column_width - 1), cell.y * @row_height, @alive,
                  cell.x * @column_width + (@column_width - 1), cell.y * @row_height + (@row_height - 1), @alive,
                  cell.x * @column_width, cell.y * @row_height + (@row_height - 1), @alive)
      else
        draw_quad(cell.x * @column_width, cell.y * @row_height, @dead,
                  cell.x * @column_width + (@column_width - 1), cell.y * @row_height, @dead,
                  cell.x * @column_width + (@column_width - 1), cell.y * @row_height + (@row_height - 1), @dead,
                  cell.x * @column_width, cell.y * @row_height + (@row_height - 1), @dead)
      end
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