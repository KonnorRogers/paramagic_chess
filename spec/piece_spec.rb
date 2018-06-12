module ParamagicChess
  RSpec.describe Piece do
    let(:piece) { Piece.new(x: 1, y: 2, pos: :a2) }

    context '#initialize' do
      it 'raises an error with no arguments given' do
        expect{ Piece.new }.to raise_error ArgumentError
      end
      it 'initializes w/ 3 arguments given' do
        expect(piece).to be_an_instance_of Piece
      end
    end

  end
end