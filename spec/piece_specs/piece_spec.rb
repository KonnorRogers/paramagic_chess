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
        expect { Piece.new(pos: :a1, side: :black) }.to_not raise_error
      end
    end

    context '#moved?' do
      it 'returns true if @moved is true' do
        expect(Piece.new(pos: :a1, moved: true).moved?).to eq true
      end

      it 'returns false if @moved is false' do
        expect(Piece.new(pos: :a1, moved: false).moved?).to eq false
      end

      it 'returns false if no args given' do
        expect(Piece.new(pos: :a1).moved?).to eq false
      end
    end
  end
end
