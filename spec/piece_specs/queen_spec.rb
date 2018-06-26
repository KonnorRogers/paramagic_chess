module ParamagicChess
  RSpec.describe Queen do
    let(:queen) { Queen.new(pos: :a2) }
    let(:black_queen) { Queen.new(pos: :a3, side: :black) }
    let(:white_queen) { Queen.new(pos: :a4, side: :white) }
    
    context '#initialize' do
      it 'creates a queen w/ position given' do
        expect(queen).to be_an_instance_of Queen
      end
      
      it 'sets the @type to :queen' do
        expect(queen.type).to eq :queen
      end
    end
    
    context 'to_s' do
      it 'Returns a black bishop unicode character' do
        expect(black_queen.to_s).to eq "\u265b"
      end
      
      it 'Returns a white queen unicode character' do
        expect(white_queen.to_s).to eq "\u2655"
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(queen.to_s).to eq 'Side not set'
      end
    end
  end
end