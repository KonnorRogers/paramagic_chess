module ParamagicChess
  RSpec.describe Pawn do
   let(:pawn) { Pawn.new(pos: :a2) }
    
    context '#initialize' do
      it 'creates a pawn w/ position given' do
        expect(pawn).to be_an_instance_of Pawn
      end
      
      it 'Will raise an arg error if no position given' do
        expect{ Pawn.new }.to raise_error ArgumentError
      end
    end 
  end
end