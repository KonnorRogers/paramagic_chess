module ParamagicChess
  RSpec.describe Bishop do
    let(:bishop) { Bishop.new(pos: :a2) }
    let(:black_bishop) { Bishop.new(pos: :h8, side: :black) }
    let(:white_bishop) { Bishop.new(pos: :h7, side: :white) }
    
    context '#initialize' do
      it 'creates a bishop w/ position given' do
        expect(bishop).to be_an_instance_of Bishop
      end
      
      it 'sets the @type to :bishop' do
        expect(bishop.type).to eq :bishop
      end
    end
    
    context 'to_s' do
      it 'Returns a black bishop unicode character' do
        expect(black_bishop.to_s).to eq "\u265d"
      end
      
      it 'Returns a white bishop unicode character' do
        expect(white_bishop.to_s).to eq "\u2657"
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(bishop.to_s).to eq 'Side not set'
      end
    end
  end
end