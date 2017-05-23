require "spec_helper"

describe Hero do
  describe ".new" do
    it "takes a name, health, and power" do
      hero = Hero.new("Frodo", 20, 5)
      expect(hero).to be_a(Hero)
    end
  end

  let(:hero) { Hero.new("Frodo", 20, 5) }
  let(:weapon) { Weapon.new("Sword", 100) }

  describe "#name" do
    it "has a reader for name" do
      expect(hero.name).to eq("Frodo")
    end
  end

  describe "#health" do
    it "has a reader for health" do
      expect(hero.health).to eq(20)
    end

    it "has a writer for health" do
      expect{ hero.health -= 1 }.to_not raise_error
      expect(hero.health).to eq(19)
    end
  end

  describe "#power" do
    it "has a reader for power" do
      expect(hero.power).to eq(5)
    end

    it "has a writer for power" do
      expect{ hero.health = 0 }.to_not raise_error
      expect(hero.health).to eq(0)
    end
  end

  describe "#weapon" do
    it "defaults to nil when there is no weapon assigned" do
      expect(hero.weapon).to eq(nil)
    end

    it "has a writer and reader" do
      expect{ hero.weapon = weapon }.to_not raise_error
      expect(hero.weapon).to eq(weapon)
    end
  end
end
