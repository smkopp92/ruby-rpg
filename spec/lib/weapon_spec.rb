require "spec_helper"

describe Weapon do
  describe ".new" do
    it "takes a name and power" do
      weapon = Weapon.new("Sting", 5)
      expect(weapon).to be_a(Weapon)
    end
  end

  let(:weapon) { Weapon.new("Sting", 5) }

  describe "#name" do
    it "has a reader for name" do
      expect(weapon.name).to eq("Sting")
    end
  end

  describe "#power" do
    it "has a reader for power" do
      expect(weapon.power).to eq(5)
    end
  end
end
