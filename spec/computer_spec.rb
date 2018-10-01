module ParamagicChess
  RSpec.describe Computer do
    let(:game) { Game.new }

    def setup_game
      game.add_computer(side: :blue)
      game.add_board
    end

    def computer
      game.update_pieces(player: game.computer)

      game.computer
    end

    context '#initialize' do
      it "sets name to computer" do
        setup_game
        expect(computer.name).to eq 'computer'
      end

      it "sets side to blue" do
        setup_game
        expect(computer.side).to eq :blue
      end

      it "provides empty array of pieces" do
        setup_game
        expect(computer.pieces).to_not be_empty
      end
    end

    context '#pick_random_piece(board:)' do
      it "picks a random piece" do
        setup_game
        expect(computer.pick_random_piece(board: game.board).class.superclass).to eq Piece
      end

      it "Choose a pieces w/ possible moves" do
        setup_game
        expect(computer.pick_random_piece(board: game.board).possible_moves).to_not be_empty
      end
    end

    context '#make_random_move' do
      it 'makes a random move on the board' do
        setup_game
        computer.make_random_move(board: game.board)
        new_board = Board.new

        expect(new_board).to_not eq game.board
      end
    end
  end
end
