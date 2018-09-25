# frozen_string_literal: true

module ParamagicChess
  class Rook < Piece
    MOVE_SET = Moves::Straight.new

    def initialize(pos: nil, side: :nil, moved: false)
      super
      @type = :rook
    end

    def to_s
      rook = "\u265c"
      return rook.blue if @side == :blue
      return rook.red if @side == :red

      'Side not set'
    end

    def update_moves(board:)
      @possible_moves = []
      @possible_moves.concat(MOVE_SET.possible_moves(board: board, piece: self))
    end

    def move_to(pos:, board:)
      update_moves(board: board)
      unless @possible_moves.include? pos
        puts ":#{pos} is an invalid move. Try again.".highlight
        return nil
      end

      super
    end
  end
end
