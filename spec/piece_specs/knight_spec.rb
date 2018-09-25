# frozen_string_literal: true

module ParamagicChess
  RSpec.describe Knight do
    let(:knight) { Knight.new(pos: :a2) }
    let(:red_knight) { Knight.new(pos: :a1, side: :red) }
    let(:blue_knight) { Knight.new(pos: :a3, side: :blue) }
    let(:board) { Board.new }

    context '#initialize' do
      it 'creates a bishop w/ position given' do
        expect(knight).to be_an_instance_of Knight
      end

      it 'sets the @type to :knight' do
        expect(knight.type).to eq :knight
      end
    end

    context 'to_s' do
      it 'Returns a red knight unicode character' do
        expect(red_knight.to_s).to eq "\u265e".red
      end

      it 'Returns a blue knight unicode character' do
        expect(blue_knight.to_s).to eq "\u265e".blue
      end

      it "Returns 'Side not set' if no side given" do
        expect(knight.to_s).to eq 'Side not set'
      end
    end

    context 'update_moves(board:)' do
      it 'returns all possible moves from starting point' do
        knight = board.board[:b1].piece
        knight.update_moves(board: board)
        expect(knight.possible_moves).to match_array %i[a3 c3]
      end

      it 'returns all possible moves from center' do
        knight = Knight.new(pos: :d4, side: :red)
        board.board[:d4].piece = knight
        knight.update_moves(board: board)
        moves = %i[c2 e2 b3 f3 c6 e6 b5 f5]
        expect(knight.possible_moves).to match_array moves
      end
    end

    context 'move_to(board: board, pos: pos)' do
      it 'allows movement of the knight' do
        knight = board.board[:b8].piece
        knight.move_to(pos: :a6, board: board)
        knight.move_to(pos: :b4, board: board)
        knight.move_to(pos: :a2, board: board)
        expect(board.board[:a2].piece).to eq knight
      end

      it 'returns an invalid move' do
        knight = board.board[:b8].piece
        expect(knight.move_to(pos: :a8, board: board)).to eq nil
      end
    end
  end
end
