module ParamagicChess
  RSpec.describe Bishop do
    let(:bishop) { Bishop.new(pos: :a2) }
    
    context '#initialize' do
      it 'creates a bishop w/ position given' do
        expect(bishop).to be_an_instance_of Bishop
      end
      
      it 'Will raise an arg error if no position given' do
        expect{ Bishop.new }.to raise_error ArgumentError
      end
      
      it 'sets the @type to :bishop' do
        expect(bishop.type).to eq :bishop
      end
    end
  end
end