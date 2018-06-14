# Expands the path of this particular file
lib_path = File.expand_path(File.dirname(__FILE__))

# Once expanded, it then finds the contents in the directory & iterates through 
# The double ** followed by /* allows constant traversal down of directory
Dir[lib_path + "/paramagic_chess/**/*.rb"].each { |file| puts file }


module ParamagicChess
  # Your code goes here...
end

# game = ParamagicChess::Board.new
# game.print_board
