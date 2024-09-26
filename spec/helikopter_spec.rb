require 'rspec'
require 'spec_helper'
require_relative '../helikopter'

RSpec.describe Helikopter do
  describe "#initialize" do
    it "initialiseert de helikopter met de juiste positie en richting" do
      expect(helikopter.instance_variable_get(:@x)).to eq(0)
      expect(helikopter.instance_variable_get(:@y)).to eq(0)
      expect(helikopter.instance_variable_get(:@z)).to eq(0)
      expect(helikopter.instance_variable_get(:@richting)).to eq("noord")
      expect(helikopter.instance_variable_get(:@instructies)).to eq("RL")
    end
  end
end