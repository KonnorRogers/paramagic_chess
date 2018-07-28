module ParamagicChess
  RSpec.describe Piece do
    let(:piece) { Piece.new(pos: :a2) }

    context '#initialize' do

      it 'initializes w/ 1 arguments given' do
        expect(piece).to be_an_instance_of Piece
      end

      it 'initializes w/ 2 keyword arguments given' do
        expect { Piece.new(pos: :a1, side: :black) }.to_not raise_error
      end

      it 'creates an array for possible moves' do
        expect(Piece.new(pos: :a1).possible_moves).to be_an_instance_of Array
      end
    end
    
    context '#to_pos(x:, y:)' do
      it 'turns an x & y value into a valid position' do
        expect(piece.to_pos(x: piece.x, y: piece.y)).to eq :a2
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

    context '#move_to(pos:, board:)' do
      it 'returns nil for :a10' do
        expect(piece.move_to(pos: :a10)).to eq nil
      end

      it 'returns nil for i1' do
        expect(piece.move_to(pos: :i1)).to eq nil
      end
      
      it 'sets the position of the piece to the :d2' do
        piece.move_to(pos: :d2)
        expect(piece.pos).to eq :d2
      end
      
      it 'updates the x & y coords to the :d & 2' do
        piece.move_to(pos: :d2)
        expect(piece.x).to eq :d
        expect(piece.y).to eq 2
      end
      
      it 'updates @moved to true' do
        expect(piece.moved).to eq false
        piece.move_to(pos: :d2)
        expect(piece.moved).to eq true
      end
      
      # it 'updates the board piece' do
      #   knight = Knight.new
      # end
    end
  end
end
