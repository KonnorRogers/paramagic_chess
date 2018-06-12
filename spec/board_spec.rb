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
    end
  end
end
