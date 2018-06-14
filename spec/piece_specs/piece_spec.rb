module ParamagicChess
  RSpec.describe Piece do
    let(:piece) { Piece.new(pos: :a2) }

    context '#initialize' do
      it 'raises an error with no arguments given' do
        expect { Piece.new }.to raise_error ArgumentError
      end

      it 'initializes w/ 1 arguments given' do
        expect(piece).to be_an_instance_of Piece
      end
    end
  end
end
