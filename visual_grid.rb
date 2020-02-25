require 'gosu'
require_relative 'game_of_life_ernesto_insua.rb'
class Visual_Grid < Gosu::Window

  def initialize(height=500, width=500)

    @height = height
    @width = width
    super height, width, false
    self.caption = "Game of Life test Ernesto Insua"

    @background = Gosu::Color.new(0xffdedede)
    @alive = Gosu::Color.new(0xff121212)
    @dead = Gosu::Color.new(0xffededed)
    @rows = height/10
    @columns = width/10

  end

  def update
  end

  def draw
  end
end

Visual_Grid.new.show