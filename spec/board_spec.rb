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
    end
  end
end
