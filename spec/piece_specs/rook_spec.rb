module ParamagicChess
  RSpec.describe Rook do
    let(:rook) { Rook.new(pos: :a2) }
    
    context '#initialize' do
      it 'creates a rook w/ position given' do
        expect(rook).to be_an_instance_of Rook
      end
      
      it 'Will raise an arg error if no position given' do
        expect{ Rook.new }.to raise_error ArgumentError
      end
      
      it 'sets the @type to :rook' do
        expect(rook.type).to eq :rook
      end
    end
  end
end