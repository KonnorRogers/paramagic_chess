module ParamagicChess
  RSpec.describe Knight do
    let(:knight) { Knight.new(pos: :a2) }
    let(:black_knight) { Knight.new(pos: :a1, side: :black) }
    let(:white_knight) { Knight.new(pos: :a3, side: :white) }
    
    context '#initialize' do
      it 'creates a bishop w/ position given' do
        expect(knight).to be_an_instance_of Knight
      end
      
      it 'sets the @type to :knight' do
        expect(knight.type).to eq :knight
      end
    end
    
    context 'to_s' do
      it 'Returns a black knight unicode character' do
        expect(black_knight.to_s).to eq "\u265e"
      end
      
      it 'Returns a white knight unicode character' do
        expect(white_knight.to_s).to eq "\u2658"
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(knight.to_s).to eq 'Side not set'
      end
    end
  end
end