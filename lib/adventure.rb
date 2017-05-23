require_relative "hero"
require_relative "weapon"
require_relative "monster"
require "pry"

class Adventure
  attr_reader :hero, :turns

  def initialize(hero, turns)
    @hero = hero
    @turns = turns
  end

  def encounter_monster(monster)
    if can_defeat_monster?(monster)
      puts "#{@hero.name} defeated #{monster.name}!"
      @hero.power += 1
    else
      puts "#{@hero.name} was defeated by #{monster.name}!"
      @hero.health = 0
    end
  end

  def encounter_trap
    @hero.health -= 1
    puts "#{@hero.name} stepped on a trap! Current Health: #{@hero.health}"
  end

  def find_potion
    @hero.health += 1
    puts "#{@hero.name} found a potion! Glug glug. Current Health: #{@hero.health}"
  end

  def take_turn
    @turns -= 1
    roll = dice_roll
    if roll%10 == 0
      encounter_monster(weak_monster)
    elsif roll%10 == 1
      find_weapon(random_weapon)
    elsif roll%5 == 2
      encounter_trap
    elsif roll == 19
      find_potion
    elsif roll == 18
      encounter_monster(strong_monster)
    else
      puts "The coast is clear. Carry on."
    end
  end

  def begin
    puts "#{@hero.name} has begun his/her epic journey of self discovery!"
    while @turns > 0 && @hero.health > 0
      self.take_turn
    end
    if @turns == 0
      puts "#{@hero.name} survived the epic journey"
    else
      puts "#{@hero.name} lost. GG. RIPeroni."
    end
  end

  def find_weapon(weapon)
    if hero.weapon.nil? || weapon.power > hero.weapon.power
      hero.weapon = weapon
      puts "#{@hero.name} equipped the #{weapon.name}!"
    else
      puts "#{@hero.name} ignored the #{weapon.name}!"
    end
  end

  private

  def can_defeat_monster?(monster)
    if @hero.weapon
      @hero.power + @hero.weapon.power > monster.power
    else
      @hero.power > monster.power
    end
  end

  def weak_monster
    Monster.new("Zubat",1)
  end

  def strong_monster
    Monster.new("Metapod", 30)
  end

  def random_weapon
    weapons.sample
  end

  def weapons
    [Weapon.new("Pokeball", 5), Weapon.new("Master Sword", 20), Weapon.new("Excalibur", 19), Weapon.new("Buster Sword", 25)]
  end

  def dice_roll
    rand(20)
  end
end

hero = Hero.new("Ashe", 10, 10)
adventure = Adventure.new(hero, 10)
# adventure.begin
