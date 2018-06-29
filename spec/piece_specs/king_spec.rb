module ParamagicChess
  RSpec.describe King do
    let(:king) { King.new(pos: :a2) }
    let(:red_king) { King.new(pos: :a1, side: :red) }
    let(:blue_king) { King.new(pos: :a3, side: :blue) }
    
    context '#initialize' do
      it 'creates a king w/ position given' do
        expect(king).to be_an_instance_of King
      end
      
      it 'sets the @type to :king' do
        expect(king.type).to eq :king
      end
    end
    
    context 'to_s' do
      it 'Returns a red king unicode character' do
        expect(red_king.to_s).to eq "\u265a".red
      end
      
      it 'Returns a blue king unicode character' do
        expect(blue_king.to_s).to eq "\u265a".blue
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(king.to_s).to eq 'Side not set'
      end
    end
  end
end