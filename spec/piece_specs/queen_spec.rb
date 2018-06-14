module ParamagicChess
  RSpec.describe Queen do
    let(:queen) { Queen.new(pos: :a2) }
    
    context '#initialize' do
      it 'creates a queen w/ position given' do
        expect(queen).to be_an_instance_of Queen
      end
      
      it 'Will raise an arg error if no position given' do
        expect{ Queen.new }.to raise_error ArgumentError
      end
    end
  end
end