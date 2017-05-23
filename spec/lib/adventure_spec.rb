require "spec_helper"

describe Adventure do
  describe ".new" do
    it "takes in a Hero and a number of turns" do
      hero = Hero.new("Frodo", 20, 5)
      adventure = Adventure.new(hero, 10)
      expect(adventure).to be_a(Adventure)
    end
  end

  let(:hero) { Hero.new("Frodo", 20, 5) }
  let(:weak_monster) { Monster.new("Zubat", 1) }
  let(:super_strong_monster) { Monster.new("Dragonite", 10) }
  let(:adventure) { Adventure.new(hero, 5) }
  let(:starting_weapon) { Weapon.new("Sting", 5) }
  let(:weak_weapon) { Weapon.new("Stick", 1) }
  let(:strong_weapon) { Weapon.new("Excalibur", 10) }

  describe "#hero" do
    it "has a reader for the hero" do
      expect(adventure.hero).to eq(hero)
    end
  end

  describe "#turns" do
    it "has a reader for turns" do
      expect(adventure.turns).to eq(5)
    end
  end

  describe "#encounter_monster" do
    it "displays success message and raises hero's power if the hero successfully defeats the monster" do
      expect{ adventure.encounter_monster(weak_monster) }.to output("#{adventure.hero.name} defeated #{weak_monster.name}!\n").to_stdout
      expect(adventure.hero.power).to eq(6)
    end
    it "displays a failure message and sets hero's health to 0 if the hero cannot defeat the monster" do
      expect{ adventure.encounter_monster(super_strong_monster) }.to output("#{adventure.hero.name} was defeated by #{super_strong_monster.name}!\n").to_stdout
      expect(adventure.hero.health).to eq(0)
    end
    it "displays success message and raises hero's power if the hero successfully defeats the monster with a weapon" do
      adventure.hero.weapon = strong_weapon
      expect{ adventure.encounter_monster(super_strong_monster) }.to output("#{adventure.hero.name} defeated #{super_strong_monster.name}!\n").to_stdout
      expect(adventure.hero.power).to eq(6)
    end
  end

  describe "#take_turn" do
    it "lowers the turn count by one" do
      adventure.take_turn
      expect(adventure.turns).to eq(4)
    end
    it "calls one of the encounter methods" do
      allow(adventure).to receive(:dice_roll).and_return(0)
      expect(adventure).to receive(:encounter_monster)
      adventure.take_turn
    end
  end

  describe "#encounter_trap" do
    it "lowers the hero's health by 1 and messages the user" do
      expect{ adventure.encounter_trap }.to output("#{adventure.hero.name} stepped on a trap! Current Health: #{adventure.hero.health - 1}\n").to_stdout
      expect(adventure.hero.health).to eq(19)
    end
  end

  describe "#find_potion" do
    it "raises the hero's health by 1 and messages the user" do
      expect{ adventure.find_potion }.to output("#{adventure.hero.name} found a potion! Glug glug. Current Health: #{adventure.hero.health + 1}\n").to_stdout
      expect(adventure.hero.health).to eq(21)
    end
  end

  describe "#find_weapon" do
    it "sets the hero's weapon to the new weapon if the hero doesn't have a weapon" do
      expect{ adventure.find_weapon(weak_weapon) }.to output("#{adventure.hero.name} equipped the #{weak_weapon.name}!\n").to_stdout
      adventure.find_weapon(weak_weapon)
      expect(hero.weapon).to eq(weak_weapon)
    end
    it "sets the hero's weapon to the new weapon if the new weapon is stronger" do
      hero.weapon = starting_weapon
      expect{ adventure.find_weapon(strong_weapon) }.to output("#{adventure.hero.name} equipped the #{strong_weapon.name}!\n").to_stdout
      adventure.find_weapon(strong_weapon)
      expect(hero.weapon).to eq(strong_weapon)
    end
    it "doesn't replace a hero's stronger weapon" do
      hero.weapon = starting_weapon
      expect{ adventure.find_weapon(weak_weapon) }.to output("#{adventure.hero.name} ignored the #{weak_weapon.name}!\n").to_stdout
      adventure.find_weapon(weak_weapon)
      expect(hero.weapon).to eq(starting_weapon)
    end
  end
end
