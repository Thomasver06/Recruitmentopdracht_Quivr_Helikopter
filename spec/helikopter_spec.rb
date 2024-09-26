require 'rspec'
require 'spec_helper'
require_relative '../helikopter'

RSpec.describe Helikopter do

  before do
    @helikopter = Helikopter.new(0, 0, 0, "noord")
  end

  describe "#initialize" do
    it "initialiseert een instance van Helikopter met beginlocatie en richting" do
      expect(@helikopter.instance_variable_get(:@x)).to eq(0)
      expect(@helikopter.instance_variable_get(:@y)).to eq(0)
      expect(@helikopter.instance_variable_get(:@z)).to eq(0)
      expect(@helikopter.instance_variable_get(:@richting)).to eq("noord")
    end
  end

  describe "#vlieg" do
    it "vliegt rechtdoor" do
      @helikopter.vlieg("V")
      expect(@helikopter.instance_variable_get(:@y)).to eq(1)
    end
    it "keert naar rechts"do
      @helikopter.vlieg("R")
      expect(@helikopter.instance_variable_get(:@richting)).to eq("oost")
    end
    it "keert naar links" do
      @helikopter.vlieg("L")
      expect(@helikopter.instance_variable_get(:@richting)).to eq("west")
    end
    it "vliegt omhoog" do
      @helikopter.vlieg("O")
      expect(@helikopter.instance_variable_get(:@z)).to eq(1)
    end
    it "vliegt omlaag" do
      @helikopter.vlieg("D")
      expect(@helikopter.instance_variable_get(:@z)).to eq(-1)
    end
    it "prints de eindlocatie van zijn vlucht" do
      expect(@helikopter.vlieg("UURVVVLVVRRVD")).to eq("3, 3, 1 zuid")
    end
    it "breekt het programma af bij ongeldige instructies" do
      expect(@helikopter.vlieg("vlieg naar leuven")).to raise_error(SystemExit)
    end
  end
end

describe "#check_input" do
  it "returns de input als deze voldoet aan de voorwaarden" do
    ARGV = ["0", "0", "0", "noord", "UURVVVLVVRVD"]
    expect(check_input).to eq(["0", "0", "0", "noord", "UURVVVLVVRRVD"])
  end
  it "vraagt nieuwe input als deze voldoet aan de voorwaarden" do
    ARGV = ["a", "b", "c", "noord"]
    expect(check_input).to have_received(:get_input)
  end
end