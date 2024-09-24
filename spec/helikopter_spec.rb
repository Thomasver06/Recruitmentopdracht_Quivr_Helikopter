require 'rspec'
require 'spec_helper'
require_relative '../helikopter'

RSpec.describe Helikopter do
  describe "#initialize" do
    it 'initialiseert de helikopter met een locatie(x, y, z), richting' do
      helikopter = Helikopter.new(200, -5, 0, "oost")
      expect(helikopter.instance_variable_get(:@x)).to eql(200)
      expect(helikopter.instance_variable_get(:@y)).to eql(-5)
      expect(helikopter.instance_variable_get(:@z)).to eql(0)
      expect(helikopter.instance_variable_get(:@richting)).to eql("oost")
    end
  end
end
