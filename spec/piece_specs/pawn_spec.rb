module ParamagicChess
  RSpec.describe Pawn do
   let(:pawn) { Pawn.new(pos: :a2) }
   let(:black_pawn) { Pawn.new(pos: :a1, side: :black) }
   let(:white_pawn) { Pawn.new(pos: :g3, side: :white) }
    
    context '#initialize' do
      it 'creates a pawn w/ position given' do
        expect(pawn).to be_an_instance_of Pawn
      end
      
      it 'Will raise an arg error if no position given' do
        expect{ Pawn.new }.to raise_error ArgumentError
      end
      
      it 'sets the @type to :pawn' do
        expect(pawn.type).to eq :pawn
      end
    end
    
    context 'to_s' do
      it 'Returns a black pawn unicode character' do
        expect(black_pawn.to_s).to eq "\u265f"
      end
      
      it 'Returns a white pawn unicode character' do
        expect(white_pawn.to_s).to eq "\u2659"
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(pawn.to_s).to eq 'Side not set'
      end
    end
    
    context '#move_to(pos:)' do
      # black_pawn.pos = 
    end
  end
end