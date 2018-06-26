module ParamagicChess
  RSpec.describe King do
    let(:king) { King.new(pos: :a2) }
    let(:black_king) { King.new(pos: :a1, side: :black) }
    let(:white_king) { King.new(pos: :a3, side: :white) }
    
    context '#initialize' do
      it 'creates a king w/ position given' do
        expect(king).to be_an_instance_of King
      end
      
      it 'sets the @type to :king' do
        expect(king.type).to eq :king
      end
    end
    
    context 'to_s' do
      it 'Returns a black bishop unicode character' do
        expect(black_king.to_s).to eq "\u265a"
      end
      
      it 'Returns a white bishop unicode character' do
        expect(white_king.to_s).to eq "\u2654"
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(king.to_s).to eq 'Side not set'
      end
    end
  end
end