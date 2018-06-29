module ParamagicChess
  RSpec.describe Rook do
    let(:rook) { Rook.new(pos: :a2) }
    let(:red_rook) { Rook.new(pos: :a2, side: :red) }
    let(:blue_rook) { Rook.new(pos: :a3, side: :blue) }
    
    context '#initialize' do
      it 'creates a rook w/ position given' do
        expect(rook).to be_an_instance_of Rook
      end
      
      it 'sets the @type to :rook' do
        expect(rook.type).to eq :rook
      end
    end
    
    context 'to_s' do
      it 'Returns a red rook unicode character' do
        expect(red_rook.to_s).to eq "\u265c".red
      end
      
      it 'Returns a white rook unicode character' do
        expect(blue_rook.to_s).to eq "\u265c".blue
      end
      
      it "Returns 'Side not set' if no side given" do
        expect(rook.to_s).to eq 'Side not set'
      end
    end
  end
end