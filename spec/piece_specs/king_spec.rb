module ParamagicChess
  RSpec.describe King do
    let(:king) { King.new(pos: :a2) }
    
    context '#initialize' do
      it 'creates a king w/ position given' do
        expect(king).to be_an_instance_of King
      end
      
      it 'Will raise an arg error if no position given' do
        expect{ King.new }.to raise_error ArgumentError
      end
    end
  end
end