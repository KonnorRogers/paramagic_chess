# frozen_string_literal: true

# Initial require for the classes that inherit piece to be able to inherit
# Piece IE: Rook < Piece
require_relative '../lib/paramagic_chess/pieces/piece.rb'
# Expands the path of this particular file
lib_path = __dir__
# Once expanded, it then finds the contents in the directory & iterates through
# The double ** followed by /* allows constant traversal down of directory
Dir[lib_path + '/paramagic_chess/**/*.rb'].each { |file| require file }
# gem for chess
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
  }.freeze
end

# leave the code below commented to run the testing suite
# uncomment to play the game
# run ruby /path/to/paramagic_chess/lib/paramagic_chess.rb
# or uncomment code and run bin/console

ParamagicChess::Game.new.play

