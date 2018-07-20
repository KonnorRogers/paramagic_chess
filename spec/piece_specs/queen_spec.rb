module ParamagicChess
  RSpec.describe Queen do
    let(:queen) { Queen.new(pos: :a2) }
    let(:red_queen) { Queen.new(pos: :a3, side: :red) }
    let(:blue_queen) { Queen.new(pos: :a4, side: :blue) }
    let(:board) { Board.new }
    
    context '#initialize' do
      it 'creates a queen w/ position given' do
        expect(queen).to be_an_instance_of Queen
      end
      
      it 'sets the @type to :queen' do
        expect(queen.type).to eq :queen
      end
    end
    
    context 'to_s' do
      it 'Returns a red queen unicode character' do
        expect(red_queen.to_s).to eq "\u265b".red
      end
      
      it 'Returns a blue queen unicode character' do
        expect(blue_queen.to_s).to eq "\u265b".blue
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(queen.to_s).to eq 'Side not set'
      end
    end
    
    context '#update_moves(board:)' do
      it 'returns an empty string from start' do
        queen = board.board[:d8].piece
        queen.update_moves(board: board)
        expect(queen.possible_moves).to be_empty
      end
      
      it 'returns all moves from center' do
        queen = Queen.new(side: :red, pos: :d5)
        board.board[:d5].piece = queen
        queen.update_moves(board: board)
        moves = %i{d6 d4 d3 d2 c6 e6 a5 b5 c5 e5 f5 g5 h5 c4
                   b3 a2 e4 f3 g2}
        expect(queen.possible_moves).to match_array moves
      end
    end
    
    context '#move_to(:board)' do
      it 'will not move from start' do
        queen = board.piece(pos: :e8)
        queen.move_to(pos: :e6, board: board)
        expect(board.piece(pos: :e8)).to eq queen
        expect(board.piece(pos: :e6)).to eq nil
      end
      
      it 'will move if the pawn in front is moved' do
        queen = board.piece(pos: :e8)
        board.board[:e7].piece = nil
        queen.move_to(pos: :e2, board: board)
        expect(board.piece(pos: :e2)).to eq queen
        expect(board.piece(pos: :e8)).to eq nil
      end
    end
  end
end