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
      it 'will return a blank array from starting point' do
        queen = board.board[:d8].piece
        queen.update_moves(board: board)
        expect(queen.possible_moves).to be_empty
      end
      
      it 'will return an array for the middle of the board' do
        queen = Queen.new(pos: :d5, side: :red)
        board.board[:d5].piece = queen
        queen.update_moves(board: board)
        moves = %i{
          c6 e6 c4 e4 f3 b3 g2 a2 d4 d3 d2 d6
          a5 b5 c5 e5 f5 g5 h5
        }
        expect(queen.possible_moves).to match_array moves
      end
    end
    
    context '#move_to(:board)' do
      it 'will not move from start' do
        queen = board.piece(pos: :d8)
        queen.move_to(pos: :d6, board: board)
        expect(board.piece(pos: :d8)).to eq queen
        expect(board.piece(pos: :d6)).to eq nil
      end
      
      it 'will move if the pawn in front is moved' do
        queen = board.piece(pos: :d8)
        board.board[:d7].piece = nil
        queen.move_to(pos: :d2, board: board)
        expect(board.piece(pos: :d2)).to eq queen
        expect(board.piece(pos: :d8)).to eq nil
      end
    end
  end
end