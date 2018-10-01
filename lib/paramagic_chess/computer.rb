require_relative 'player.rb'

module ParamagicChess
  # AI for chess game
  class Computer < Player
    def initialize(name: 'computer', side: nil)
      super
    end

    def computer?
      true
    end

    def pick_random_piece
      @pieces.sample
    end

    def make_random_move(piece:, board:)
      # select end destination
      end_pos = piece.possible_moves.sample

      # send to game
      piece.move_to(board: board, pos: end_pos)
    end
  end
end
