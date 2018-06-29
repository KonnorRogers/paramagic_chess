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
      it 'provides the 2 most basic starting moves. a7 to a6 or a5.' do
      
        red_pawn.update_red_moves(board: board)
        
        expect(red_pawn.possible_moves).to match_array [:a6, :a5]
      end
    end

    context '#move_to(pos:, board:)' do

    end
  end
end
