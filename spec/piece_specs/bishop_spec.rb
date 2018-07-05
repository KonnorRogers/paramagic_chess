module ParamagicChess
  RSpec.describe Bishop do
    let(:bishop) { Bishop.new(pos: :a2) }
    let(:red_bishop) { Bishop.new(pos: :h8, side: :red) }
    let(:blue_bishop) { Bishop.new(pos: :h7, side: :blue) }

    context '#initialize' do
      it 'creates a bishop w/ position given' do
        expect(bishop).to be_an_instance_of Bishop
      end

      it 'sets the @type to :bishop' do
        expect(bishop.type).to eq :bishop
      end
    end

    context 'to_s' do
      it 'Returns a red bishop unicode character' do
        expect(red_bishop.to_s).to eq "\u265d".red
      end

      it 'Returns a blue bishop unicode character' do
        expect(blue_bishop.to_s).to eq "\u265d".blue
      end

      it "Returns 'Side not set' if no side given" do
        expect(bishop.to_s).to eq 'Side not set'
      end
    end

    context 'red' do

    end
  end
end
