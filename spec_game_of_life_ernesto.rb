require 'rspec'
require_relative 'game_of_life_ernesto_insua.rb'
require_relative 'game_world.rb'
require_relative 'cell.rb'

describe 'Game of life Ernesto' do

  context 'Game_World' do

    subject { Game_World.new }
    it 'Create a new Game_World' do
      expect(subject.is_a?(Game_World)).to eq(true)
    end

    it 'Responds to created methods' do
      expect(subject).to respond_to(:columns)
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cells_grid)
    end

    it 'Responds to created cells_grid array' do
      #Test that is an array
      expect(subject.cells_grid.is_a?(Array)).to eq(true)
      #Test that the inner elements are an array too
      subject.cells_grid.each do |row|
        expect(row.is_a?(Array)).to eq(true)
        row.each do |element|
          expect(element.is_a?(Cell)).to eq(true)
        end
      end
    end
  end

  context 'Cell' do

    subject { Cell.new }
    it 'Create a new Cell' do
      expect(subject.is_a?(Cell)).to eq(true)
    end

  end
end