class Hero
  attr_reader :name
  attr_accessor :health, :weapon, :power

  def initialize(name, health, power)
    @name = name
    @health = health
    @power = power
    @weapon = nil
  end
end
