module ParamagicChess
  RSpec.describe Piece do
    let(:piece) { Piece.new(pos: :a2) }

    context '#initialize' do
      it 'raises an error with no arguments given' do
        expect { Piece.new }.to raise_error ArgumentError
      end
      
      it 'Raises an error if the position is not on the board' do
        expect { Piece.new(pos: :i2) }.to raise_error ArgumentError
        expect { Piece.new(pos: :h9) }.to raise_error ArgumentError
      end

      it 'initializes w/ 1 arguments given' do
        expect(piece).to be_an_instance_of Piece
      end
      
      it 'initializes w/ 2 keyword arguments given' do
        expect { Piece.new(pos: :a1, side: :black) }.to_not raise_error ArgumentError
      end
    end
  end
end
