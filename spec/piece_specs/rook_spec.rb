# frozen_string_literal: true

module ParamagicChess
  RSpec.describe Rook do
    let(:rook) { Rook.new(pos: :a2) }
    let(:red_rook) { Rook.new(pos: :a2, side: :red) }
    let(:blue_rook) { Rook.new(pos: :a3, side: :blue) }
    let(:board) { Board.new }

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

    context '#update_moves(:board)' do
      it 'does not allow movement from starting point' do
        rook = board.board[:a8].piece
        rook.update_moves(board: board)
        expect(rook.possible_moves).to be_empty
      end

      it 'allows movement all the way to :a2 - red' do
        rook = board.board[:a8].piece
        board.board[:a7].piece = nil
        rook.update_moves(board: board)
        moves = %i[a7 a6 a5 a4 a3 a2]

        expect(rook.possible_moves).to match_array moves
      end

      it 'allows complete horizontal movement - red' do
        rook = Rook.new(pos: :a6, side: :red)
        board.board[:a6].piece = rook
        rook.update_moves(board: board)

        moves = %i[b6 c6 d6 e6 f6 g6 h6 a2 a3 a4 a5]

        expect(rook.possible_moves).to match_array moves
      end

      it 'allows movement all the way to :a2 - blue' do
        rook = board.board[:a1].piece
        board.board[:a2].piece = nil
        rook.update_moves(board: board)
        moves = %i[a7 a6 a5 a4 a3 a2]

        expect(rook.possible_moves).to match_array moves
      end

      it 'allows complete horizontal movement - blue' do
        rook = Rook.new(pos: :a3, side: :blue)
        board.board[:a3].piece = rook
        rook.update_moves(board: board)

        moves = %i[b3 c3 d3 e3 f3 g3 h3 a4 a5 a6 a7]

        expect(rook.possible_moves).to match_array moves
      end
    end

    context '#move_to(pos:, board:)' do
      it 'will not move from starting point' do
        rook = board.board[:a8].piece
        rook.move_to(board: board, pos: :a6)
        expect(rook.pos).to eq :a8
        expect(board.board[:a8].piece).to eq rook
      end

      it 'will move if the pawn is gone.' do
        rook = board.board[:a8].piece
        board.board[:a7].piece = nil
        rook.move_to(board: board, pos: :a2)
        expect(board.board[:a2].piece).to eq rook
        rook.move_to(board: board, pos: :b2)
        expect(board.board[:a2].piece).to eq nil
        expect(board.board[:b2].piece).to eq rook
      end
    end
  end
end
