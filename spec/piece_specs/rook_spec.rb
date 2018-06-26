module ParamagicChess
  RSpec.describe Rook do
    let(:rook) { Rook.new(pos: :a2) }
    let(:black_rook) { Rook.new(pos: :a2, side: :black) }
    let(:white_rook) { Rook.new(pos: :a3, side: :white) }
    
    context '#initialize' do
      it 'creates a rook w/ position given' do
        expect(rook).to be_an_instance_of Rook
      end
      
      it 'sets the @type to :rook' do
        expect(rook.type).to eq :rook
      end
    end
    
    context 'to_s' do
      it 'Returns a black rook unicode character' do
        expect(black_rook.to_s).to eq "\u265c"
      end
      
      it 'Returns a white rook unicode character' do
        expect(white_rook.to_s).to eq "\u2656"
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(rook.to_s).to eq 'Side not set'
      end
    end
  end
end