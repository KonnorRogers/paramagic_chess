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

    def update_piece_moves(board:)
      @pieces.each { |piece| piece.update_moves(board: board) }
    end

    def pick_random_piece(board:)
      update_piece_moves(board: board)
      # creates an array of pieces then randomly selects 1 with sample
      pieces_with_moves = @pieces.reject { |piece| piece.possible_moves.empty? }
      pieces_with_moves.sample
    end

    def make_random_move(board:)
      piece = pick_random_piece(board: board)
      # select end destination
      end_pos = piece.possible_moves.sample
      # send to game
      puts "moving #{piece.starting_pos} to #{end_pos}"
      piece.move_to(board: board, pos: end_pos)
    end
  end
end
