module ParamagicChess
  RSpec.describe Queen do
    let(:queen) { Queen.new(pos: :a2) }
    let(:red_queen) { Queen.new(pos: :a3, side: :red) }
    let(:blue_queen) { Queen.new(pos: :a4, side: :blue) }
    let(:board) { Board.new }

    context '#initialize' do
      it 'creates a queen w/ position given' do
        expect(queen).to be_an_instance_of Queen
      end

      it 'sets the @type to :queen' do
        expect(queen.type).to eq :queen
      end
    end

    context 'to_s' do
      it 'Returns a red queen unicode character' do
        expect(red_queen.to_s).to eq "\u265b".red
      end

      it 'Returns a blue queen unicode character' do
        expect(blue_queen.to_s).to eq "\u265b".blue
      end

      it "Returns 'Side not set' if no side given" do
        expect(queen.to_s).to eq 'Side not set'
      end
    end
  end
end