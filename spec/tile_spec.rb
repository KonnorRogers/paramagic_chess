# frozen_string_literal: true

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

    context '#contains_piece?' do
      it 'returns true if @piece is not nil' do
        tile.piece = 'fake_piece'
        expect(tile.contains_piece?).to eq true
      end

      it 'returns false if @piece is nil' do
        expect(tile.contains_piece?).to eq false
      end
    end

    context '#to_s' do
      it 'sets background to black if no piece occupies the space' do
        tile.background = :black

        expect(tile.to_s).to eq " \u265f ".black.bg_black
      end

      it 'sets background to white if no piece occupies the space' do
        tile.background = :white

        expect(tile.to_s).to eq " \u265f ".white.bg_white
      end

      it 'sets background to black and puts the piece in the middle' do
        queen = Queen.new(pos: :a1, side: :blue)
        tile = Tile.new(position: :a1, piece: queen, background: :black)

        expect(tile.to_s).to eq queen.to_s.bg_black
      end
    end
  end
end
