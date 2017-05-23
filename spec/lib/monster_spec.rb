require "spec_helper"

describe Monster do
  describe ".new" do
    it "takes a name and power" do
      monster = Monster.new("Zubat", 1)
      expect(monster).to be_a(Monster)
    end
  end

  let(:monster) { Monster.new("Zubat", 1) }

  describe "#name" do
    it "has a reader for name" do
      expect(monster.name).to eq("Zubat")
    end
  end

  describe "#power" do
    it "has a reader for power" do
      expect(monster.power).to eq(1)
    end
  end
end
