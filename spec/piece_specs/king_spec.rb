module ParamagicChess
  RSpec.describe King do
    let(:king) { King.new(pos: :a2) }
    let(:red_king) { King.new(pos: :a1, side: :red) }
    let(:blue_king) { King.new(pos: :a3, side: :blue) }
    let(:board) { Board.new }
    
    context '#initialize' do
      it 'creates a king w/ position given' do
        expect(king).to be_an_instance_of King
      end
      
      it 'sets the @type to :king' do
        expect(king.type).to eq :king
      end
    end
    
    context 'to_s' do
      it 'Returns a red king unicode character' do
        expect(red_king.to_s).to eq "\u265a".red
      end
      
      it 'Returns a blue king unicode character' do
        expect(blue_king.to_s).to eq "\u265a".blue
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(king.to_s).to eq 'Side not set'
      end
    end
    
    context '#update_moves(board:)' do
      it 'returns a blank array from starting point' do
        king = board.board[:e8].piece
        king.update_moves(board: board)
        expect(king.possible_moves).to be_empty
      end
      
      it 'returns all possible moves from center of board' do
        king = King.new(pos: :d5, side: :red)
        board.board[:d5].piece = king
        king.update_moves(board: board)
        expect(king.possible_moves).to match_array %i{d6 d4 c5 c4 c6 e5 e4 e6}
      end
      
      it 'returns possible moves when couple pieces removed' do
        king = board.board[:e8].piece
        board.board[:f7].piece = nil
        board.board[:c7].piece = nil
        board.board[:e7].piece = nil
        king.update_moves(board: board)
        expect(king.possible_moves).to match_array %i{d7 f7 e7}
      end
    end
    
    context 'move_to(board:, pos:)' do
      it 'will not move anywhere from start' do
        king = board.board[:e1].piece
        king.move_to(board: board, pos: :d2)
        expect(board.board[:e1].piece).to eq king
      end
      
      it 'will move when a piece is moved' do
        king = board.board[:e1].piece
        board.board[:e2].piece = nil
        king.move_to(pos: :e2, board: board)
        expect(board.board[:e1].piece).to eq nil
        expect(board.board[:e2].piece).to eq king
      end
      
      it 'will not move if movement too far' do
        king = board.board[:e1].piece
        board.board[:e2].piece = nil
        king.move_to(pos: :e3, board: board)
        
        expect(board.board[:e3].piece).to eq nil
        expect(board.board[:e1].piece).to eq king
      end
    end
    
    context '#rooks(board:)' do
      it 'returns both rooks on a clean board for side red' do
        red_king = board.board[:e8].piece
        
        rook_array = red_king.rooks(board: board)
        red_rooks = []
        red_rooks << board.board[:h8].piece
        red_rooks << board.board[:a8].piece
        expect(rook_array).to match_array red_rooks
      end
      
      it 'returns an empty array if both rooks are gone' do
        red_king = board.board[:e8].piece
        board.board[:h8].piece = nil
        board.board[:a8].piece = nil
        rook_array = red_king.rooks(board: board)
        expect(rook_array).to be_empty
      end
    end
    
    context '#rook_right(board:)' do
      it 'returns the rook to the right IF is at starting position for red' do
        red_king = board.board[:e8].piece
        red_right_rook = board.board[:h8].piece 
        
        expect(red_king.rook_right(board: board)).to eq red_right_rook
      end
      
      it 'returns the rook to the right IF it is at starting position for blue' do
        blue_king = board.board[:e1].piece
        blue_right_rook = board.board[:h1].piece 
        
        expect(blue_king.rook_right(board: board)).to eq blue_right_rook
      end
    end
  end
end