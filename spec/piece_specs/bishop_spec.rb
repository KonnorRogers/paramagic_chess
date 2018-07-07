module ParamagicChess
  RSpec.describe Bishop do
    let(:bishop) { Bishop.new(pos: :a2) }
    let(:red_bishop) { Bishop.new(pos: :h8, side: :red) }
    let(:blue_bishop) { Bishop.new(pos: :h7, side: :blue) }
    let(:board) { Board.new }

    context '#initialize' do
      it 'creates a bishop w/ position given' do
        expect(bishop).to be_an_instance_of Bishop
      end

      it 'sets the @type to :bishop' do
        expect(bishop.type).to eq :bishop
      end
    end

    context 'to_s' do
      it 'Returns a red bishop unicode character' do
        expect(red_bishop.to_s).to eq "\u265d".red
      end

      it 'Returns a blue bishop unicode character' do
        expect(blue_bishop.to_s).to eq "\u265d".blue
      end

      it "Returns 'Side not set' if no side given" do
        expect(bishop.to_s).to eq 'Side not set'
      end
    end

    context 'update_moves(board:)' do
      it 'returns no possible moves on a new board' do
        red_bishop = board.board[:c8].piece
        red_bishop.update_moves(board: board)
        expect(red_bishop.possible_moves).to be_empty
      end
      
      it 'allows movement up and to the right' do
        board.board[:d7].piece.move_to(pos: :d5, board: board)
        red_bishop = board.board[:c8].piece
        red_bishop.update_moves(board: board)
        expect(red_bishop.possible_moves).to eq %i{d7 e6 f5 g4 h3}
      end
    end
  end
end
