module ParamagicChess
  RSpec.describe Tile do
    let(:tile) { Tile.new(position: :a1) }

    context '#initialize' do
      it 'initializes with position keyword' do
        expect(tile).to be_an_instance_of Tile
      end

      it 'Will not initialize w/ no arguments' do
        expect { Tile.new }.to raise_error ArgumentError
      end

      it 'Will intialize w/ position, background, & piece arguments' do
        tile = Tile.new(position: :a1, background: :white, piece: 'piece')
        expect(tile).to be_an_instance_of Tile
      end
    end
  end
end
