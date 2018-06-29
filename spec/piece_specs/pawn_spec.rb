module ParamagicChess
  RSpec.describe Pawn do
    let(:pawn) { Pawn.new(pos: :a2) }
    let(:red_pawn) { Pawn.new(pos: :a7, side: :red) }
    let(:blue_pawn) { Pawn.new(pos: :a2, side: :blue) }
    let(:board) { Board.new }

    context '#initialize' do
      it 'creates a pawn w/ position given' do
        expect(pawn).to be_an_instance_of Pawn
      end

      it 'sets the @type to :pawn' do
        expect(pawn.type).to eq :pawn
      end
    end

    context 'to_s' do
      it 'Returns a red pawn unicode character' do
        expect(red_pawn.to_s).to eq "\u265f".red
      end

      it 'Returns a blue pawn unicode character' do
        expect(blue_pawn.to_s).to eq "\u265f".blue
      end

      it "Returns 'Side not set' if no side given" do
        expect(pawn.to_s).to eq 'Side not set'
      end
    end
    
    context '#update_red_moves(board:)' do
      it 'provides the 2 most basic starting moves.  from a7 to a6 or a5.' do
      
        red_pawn.update_red_moves(board: board)
        
        expect(red_pawn.possible_moves).to match_array [:a6, :a5]
      end
      
      it 'allows for movement from :a7 to :b6' do
        board.board[:b6].piece = Knight.new(pos: :b6, side: :blue)
        # board.print_board
        
        red_pawn.update_red_moves(board: board)
        expect(red_pawn.possible_moves).to match_array [:a6, :a5, :b6]
      end
      
      it 'allows for movement from :b7 to :a6 & :c6' do
        board.board[:a6].piece = Knight.new(pos: :a6, side: :blue)
        board.board[:c6].piece = Pawn.new(pos: :c6, side: :blue)
        
        red_pawn.update_position(pos: :b7)
        board.print_board
        
        red_pawn.update_red_moves(board: board)
        expect(red_pawn.possible_moves).to match_array [:b6, :b5, :c6, :a6]
        
      end
    end

    context '#move_to(pos:, board:)' do

    end
  end
end
