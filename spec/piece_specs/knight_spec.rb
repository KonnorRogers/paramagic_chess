module ParamagicChess
  RSpec.describe Knight do
    let(:knight) { Knight.new(pos: :a2) }
    
    context '#initialize' do
      it 'creates a bishop w/ position given' do
        expect(knight).to be_an_instance_of Knight
      end
      
      it 'Will raise an arg error if no position given' do
        expect{ Knight.new }.to raise_error ArgumentError
      end
      
      it 'sets the @type to :knight' do
        expect(knight.type).to eq :knight
      end
    end
  end
end