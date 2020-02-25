class Cell
  attr_accessor :x, :y, :alive

  def initialize(x = 0, y = 0)
    #coordinates
    @x = x
    @y = y
    @alive = false
  end


  def alive?; alive; end
  def dead?; !alive; end

  def die!
    @alive = false
  end

  def reborn!
    self.alive = true
  end

end