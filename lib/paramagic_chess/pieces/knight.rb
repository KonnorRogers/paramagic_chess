# frozen_string_literal: true

module ParamagicChess
  class Knight < Piece
    MOVE_SET = Moves::L_Move.new

    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :knight
    end

    def to_s
      knight = "\u265e"
      return knight.blue if @side == :blue
      return knight.red if @side == :red

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
