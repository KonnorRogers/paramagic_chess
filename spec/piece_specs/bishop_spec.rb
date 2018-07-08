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
      
      it 'allows movement up and to the right for red' do
        board.board[:d7].piece.move_to(pos: :d5, board: board)
        red_bishop = board.board[:c8].piece
        red_bishop.update_moves(board: board)
        expect(red_bishop.possible_moves).to eq %i{d7 e6 f5 g4 h3}
      end
      
      it 'allows movement up and to the right for blue' do
        board.board[:d2].piece.move_to(pos: :d4, board: board)
        blue_bishop = board.board[:c1].piece
        blue_bishop.update_moves(board: board)
        expect(blue_bishop.possible_moves).to eq %i{d2 e3 f4 g5 h6} 
      end
      
      it 'allow for all possible movements from center' do
        blue_bishop = Bishop.new(pos: :d4, side: :blue)
        board.board[:d4].piece = blue_bishop
        blue_bishop.update_moves(board: board)
        moves = %i{c3 e3 c5 b6 a7 e5 f6 g7}
        expect(blue_bishop.possible_moves).to match_array moves
      end
    end
    
    context '#move_to(board:, pos:)' do
      it 'will not move from starting point' do
        bishop = board.board[:c1].piece
        bishop.move_to(board: board, pos: :e3)
        expect(board.board[:c1].piece).to eq bishop
      end
      
      it 'will move when the pawn is moved' do
        bishop = board.board[:c1].piece
        board.board[:d2].piece.move_to(board: board, pos: :d4)
        bishop.move_to(board: board, pos: :h6)
        bishop.move_to(board: board, pos: :g7)
        expect(board.board[:g7].piece).to eq bishop
        bishop.move_to(board: board, pos: :h8)
        expect(board.board[:g7].piece).to eq nil
        expect(board.board[:h8].piece).to eq bishop
      end
    end
  end
end
