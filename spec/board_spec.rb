# frozen_string_literal: true

module ParamagicChess
  RSpec.describe Board do
    let(:board) { Board.new }

    context '#initialize' do
      it 'sets @board to a hash' do
        expect(board.board).to be_an_instance_of Hash
      end

      it 'sets @board to a size of 64 (8x8)' do
        expect(board.board.size).to eq 64
      end

      it 'allows for items items to be accessed w/ letter + number combo' do
        expect(board.board[:a1]).to be_an_instance_of Tile
      end

      it 'sets the position of the tile to be a num + letter value' do
        expect(board.board[:h8].position).to eq :h8
      end

      it 'sets the backgrounds appropriately' do
        expect(board.board[:a1].background).to eq :white
        expect(board.board[:a2].background).to eq :black
      end
    end

    context '#place_pieces (private method)' do
      it 'Sets all 32 pieces on the board' do
        pieces = board.board.select { |_k, v| v.contains_piece? }
        expect(pieces.size).to eq 32
      end

      it 'Sets 16 blue pieces' do
        pieces = board.board.select { |_k, v| v.contains_piece? && v.piece.side == :blue }
        expect(pieces.size).to eq 16
      end

      it 'Sets 16 red pieces' do
        pieces = board.board.select { |_k, v| v.contains_piece? && v.piece.side == :red }
        expect(pieces.size).to eq 16
      end
    end
  end
end
