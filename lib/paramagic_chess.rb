# file = "paramagic_chess"
# pieces = file + "/pieces"

# require "#{file}/version"
# require "#{pieces}/piece"
# require "#{file}/tile"
# require "#{file}/board"

Dir.entries('lib/paramagic_chess').each { |file| require_relative file if file =~ /\*.rb/ }
Dir.entries('lib/paramagic_chess/pieces').each { |file| require_relative file }

# Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }


# Dir["../paramagic_chess/pieces/*.rb"].each { |file| require_relative file }

module ParamagicChess
  # Your code goes here...
end

# game = ParamagicChess::Board.new
# game.print_board
