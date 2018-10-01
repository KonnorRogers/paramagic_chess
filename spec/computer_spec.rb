module ParamagicChess
  RSpec.describe Computer do
    let(:board) { Board.new }
    let(:computer) { Computer.new }

    context '#initialize' do
      it "sets name to computer" do
        expect(computer.name).to eq 'computer'
      end
    end

    context '#pick_random_piece' do

    end
  end
end
