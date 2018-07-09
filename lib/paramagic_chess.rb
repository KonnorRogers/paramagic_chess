# Initial require for the classes that inherit piece to be able to inherit
# Piece IE: Rook < Piece
require "paramagic_chess/pieces/piece"

# Expands the path of this particular file
lib_path = File.expand_path(File.dirname(__FILE__))
# Once expanded, it then finds the contents in the directory & iterates through
# The double ** followed by /* allows constant traversal down of directory
Dir[lib_path + "/paramagic_chess/**/*.rb"].each { |file| require file }

module ParamagicChess

  def self.create_char_to_num_hash
    hash = {}
    ('a'..'h').each_with_index do |letter, index|
      hash[letter.to_sym] = index + 1
    end
    hash
  end

  def self.create_num_to_char_hash
    {
      1 => :a,
      2 => :b,
      3 => :c,
      4 => :d,
      5 => :e,
      6 => :f,
      7 => :g,
      8 => :h
    }
  end

  CHAR_TO_NUM = create_char_to_num_hash
  NUM_TO_CHAR = create_num_to_char_hash
  PROMOTION_LIST = {
    bishop: Bishop.new,
    knight: Knight.new,
    queen: Queen.new,
    rook: Rook.new
  }

end

# game = ParamagicChess::Board.new
# game.print_board
# game.board[:c8].piece.update_moves(board: game)
# p game.board[:c8].piece.possible_moves


# game.board[:d4] = ParamagicChess::Queen.new(pos: :d4, side: :white)
# game.print_board