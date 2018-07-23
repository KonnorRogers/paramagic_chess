module ParamagicChess
  RSpec.describe Pawn do
    let(:pawn) { Pawn.new(pos: :a2) }
    let(:red_pawn) { Pawn.new(pos: :a7, side: :red) }
    let(:blue_pawn) { Pawn.new(pos: :a2, side: :blue) }
    let(:board) { Board.new }

    context '#initialize' do
      it 'creates a pawn w/ position given' do
        expect(pawn).to be_an_instance_of Pawn
      end

      it 'sets the @type to :pawn' do
        expect(pawn.type).to eq :pawn
      end
    end

    context 'to_s' do
      it 'Returns a red pawn unicode character' do
        expect(red_pawn.to_s).to eq "\u265f".red
      end

      it 'Returns a blue pawn unicode character' do
        expect(blue_pawn.to_s).to eq "\u265f".blue
      end

      it "Returns 'Side not set' if no side given" do
        expect(pawn.to_s).to eq 'Side not set'
      end
    end

    context '#update_moves(board:) - red_pawn' do
      it 'provides the 2 most basic starting moves.  from a7 to a6 or a5.' do
        red_pawn.update_moves(board: board)

        expect(red_pawn.possible_moves).to match_array %i[a6 a5]
      end

      it 'Will not allow for movement 2 spaces if moved = true' do
        red_pawn.move_to(pos: :a6, board: board)
        # sets @moved to true

        red_pawn.update_moves(board: board)
        expect(red_pawn.possible_moves).to match_array [:a5]
      end

      it 'allows for movement from :a7 to :b6' do
        board.board[:b6].piece = Knight.new(pos: :b6, side: :blue)

        red_pawn.update_moves(board: board)
        # %i makes all symbols in the array
        expect(red_pawn.possible_moves).to match_array %i[a6 a5 b6]
      end

      it 'allows for movement from :b7 to :a6 & :c6' do
        board.board[:a6].piece = Knight.new(pos: :a6, side: :blue)
        board.board[:c6].piece = Pawn.new(pos: :c6, side: :blue)

        red_pawn.update_position(pos: :b7)

        red_pawn.update_moves(board: board)
        expect(red_pawn.possible_moves).to match_array %i[b6 b5 c6 a6]
      end

      it 'will return an empty array if another red piece is in front of the pawn' do
        board.board[:a6].piece = Pawn.new(pos: :a6, side: :red)
        red_pawn.update_moves(board: board)
        expect(red_pawn.possible_moves).to be_empty
      end

      it 'will return an empty array if another blue piece is in front of the pawn' do
        board.board[:a6].piece = Pawn.new(pos: :a6, side: :blue)
        red_pawn.update_moves(board: board)
        expect(red_pawn.possible_moves).to be_empty
      end
    end

    context '#update_moves(board:) - blue_pawn' do
      it 'provides basic first 2 moves for a pawn' do
        blue_pawn.update_moves(board: board)
        expect(blue_pawn.possible_moves).to match_array %i[a3 a4]
      end

      it 'will return an empty array if another red piece is in front of the pawn' do
        board.board[:a3].piece = Pawn.new(pos: :a3, side: :blue)
        blue_pawn.update_moves(board: board)
        expect(blue_pawn.possible_moves).to be_empty
      end

      it 'will return only :a3 if :a4 is taken' do
        board.board[:a4].piece = Pawn.new(pos: :a4, side: :red)
        blue_pawn.update_moves(board: board)
        expect(blue_pawn.possible_moves).to match_array %i[a3]
      end

      it 'accounts for an en passant case on both sides for blue' do
        pawn_blue = Pawn.new(pos: :b5, side: :blue)
        board.board[:b5].piece = pawn_blue
        board.board[:a7].piece.move_to(pos: :a5, board: board)
        board.board[:c7].piece.move_to(pos: :c5, board: board)

        pawn_blue.update_moves(board: board)
        expect(pawn_blue.possible_moves).to match_array %i{b6 c6 a6}
      end

      it 'accounts for an en passant on both sides case for red' do
        pawn_red = Pawn.new(pos: :b4, side: :red)
        board.board[:b4].piece = pawn_red
        board.board[:a2].piece.move_to(pos: :a4, board: board)
        board.board[:c2].piece.move_to(pos: :c4, board: board)

        pawn_red.update_moves(board: board)
        expect(pawn_red.possible_moves).to match_array %i{b3 c3 a3}
      end

      it 'accounts for only 1 en passant for blue' do
        pawn_blue = Pawn.new(pos: :b5, side: :blue)
        board.board[:b5].piece = pawn_blue
        board.board[:a7].piece.move_to(pos: :a5, board: board)

        pawn_blue.update_moves(board: board)
        expect(pawn_blue.possible_moves).to match_array %i{b6 a6}
      end

      it 'accounts for only 1 en passant for red' do
        pawn_red = Pawn.new(pos: :b4, side: :red)
        board.board[:b4].piece = pawn_red
        board.board[:a2].piece.move_to(pos: :a4, board: board)

        pawn_red.update_moves(board: board)
        expect(pawn_red.possible_moves).to match_array %i{b3 a3}
      end
    end

    context '#move_to(pos:, board:)' do
      it 'updates the board that the pawn is now at :a5' do
        red_pawn.move_to(pos: :a5, board: board)

        expect(red_pawn.pos).to eq :a5
        expect(board.board[:a5].piece).to eq red_pawn
      end

      it 'removes the piece @ :b6' do
        knight_b6 = Knight.new(pos: :b6, side: :blue)
        board.board[:b6].piece = knight_b6
        red_pawn.move_to(pos: :b6, board: board)


        expect(red_pawn.pos).to eq :b6
        expect(board.board[:b6].piece).to eq red_pawn
        expect(board.removed_blue_pieces).to match_array [knight_b6]
      end

      it 'returns that it is an invalid move' do
        error = red_pawn.move_to(pos: :b6, board: board)
        expect(red_pawn.pos).to eq :a7
        expect(board.board[:a7].piece.type).to eq :pawn
        expect(error).to eq ':b6 is an invalid move. Try again.'
      end

      it 'Allows the ability to promote' do
        board.board[:b1].piece = nil

        red_pawn.move_to(pos: :a5, board: board)

        red_pawn.move_to(pos: :a4, board: board)
        red_pawn.move_to(pos: :a3, board: board)
        red_pawn.move_to(pos: :b2, board: board)
        red_pawn.move_to(pos: :b1, board: board, input: :knight)
        # board.print_board
        expect(board.board[:b1].piece).to be_an_instance_of Knight
      end

      it 'Allows the ability to promote' do
        board.board[:b8].piece = nil

        blue_pawn.move_to(pos: :a4, board: board)

        blue_pawn.move_to(pos: :a5, board: board)
        blue_pawn.move_to(pos: :a6, board: board)
        blue_pawn.move_to(pos: :b7, board: board)
        blue_pawn.move_to(pos: :b8, board: board, input: :knight)
        # board.print_board
        expect(board.board[:b1].piece).to be_an_instance_of Knight
      end

      it 'Works with en_passant' do
        red_pawn.move_to(pos: :a5, board: board)
        red_pawn.move_to(pos: :a4, board: board)
        board.board[:b2].piece.move_to(pos: :b4, board: board)
        red_pawn.move_to(pos: :b3, board: board)
        expect(board.board[:b4].piece).to eq nil
      end
      
      it 'should not remove both pieces' do 
        red_pawn = board.board[:b7].piece
        red_pawn.move_to(pos: :b5, board: board)
        blue_pawn = board.board[:a2].piece
        blue_pawn.move_to(pos: :a4, board: board)
        red_pawn.move_to(pos: :b4, board: board)
        blue_rook = board.board[:a1].piece
        blue_rook.move_to(pos: :a3, board: board)
        blue_pawn.double_move = false
        red_pawn.move_to(pos: :a3, board: board)
        expect(board.board[:a3].piece).to eq red_pawn
        expect(board.board[:a4].piece).to eq blue_pawn
        
        
      end
    end
  end
end
