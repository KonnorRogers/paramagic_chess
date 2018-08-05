require 'yaml'

module ParamagicChess
  class Game
    SAFE_WORDS = [:save, :load, :castle, :exit]
    DIRNAME = "saved_games/"
    
    attr_accessor :players
    attr_reader :board
    
    def initialize
      @board = Board.new
      @players = []
      @turn = :red
    end
    
    # player1, player2, and input all added for testing purposes
    def add_players(player1: 'konnor', player2: 'evelyn', input: :n)
      add_player(name: player1)
      add_computer_or_player(player: player2, input: input)
    end
    
    def play
      greeting_message
      # load_game
      add_players
      randomize_sides
      
      loop do
        print_game
        update_pieces
        take_turn
        break if game_over?
      end
      
      
    end
    
    def randomize_sides
      @players.shuffle!
      @players[0].side = :red
      @players[1].side = :blue
    end
    
    def greeting_message
      system 'clear'
      print "Welcome to ParamagicChess. Theres nothing magical here Just Chess. \n"
      puts 'Would you like to load a previous game? (Y/N)'
    end
    
    def game_over?
      if player_1.check_mate == true || player_2.check_mate == true
        puts "CONGRATULATIONS! #{winner.name}, you have won!"
        puts "Sorry, #{loser.name} you have lost."
        return true
      end
      false
    end
    
    def player_1
      @players[0]
    end
    
    def player_2
      @players[1]
    end
    
    def get_input(input: nil)
      input ||= gets.chomp.downcase
      # checks for safewords
      return send((input + "_game").to_sym) if SAFE_WORDS.include?(input.to_sym)
      
      input = input.split(' to ')
      
      return if good_input(input: input).nil?
      
      [input[0].to_sym, input[1].to_sym]
    end
    
    def update_pieces(player: get_player_turn)
      player.pieces = []
      @board.board.each do |_coord, tile|
        next if tile.piece.nil?
        player.pieces << tile.piece if tile.piece.side == player.side
      end
    end
    
    private
    
    def winner
      return player_2 if player_1.check_mate == true
      return player_1 if player_2.check_mate == true
      false
    end
    
    def loser
      return player_2 if winner == player_1
      return player_1 if winner == player_2
      false
    end
    
    def good_input(input:)
      #checks for if to is included
      unless input.length == 2 
        puts 'Please follow the example of a2 to a4.'
        return nil
      end
      # checks for letters
      return nil unless CHAR_TO_NUM.include?(input[0][0].to_sym)
      return nil unless CHAR_TO_NUM.include?(input[1][0].to_sym)
      
      # checks for board size
      return nil if input[0][1].to_i < 1 || input[1][1].to_i < 1
      return nil if input[0][1].to_i > 8 || input[1][1].to_i > 8
      
      input
    end
    
    def exit_game
      exit!
    end
    
    def save_game
      dir_path = File.expand_path(File.dirname(__FILE__)).split("lib")[0] + DIRNAME
      Dir.mkdir(dir_path) unless Dir.exist?(dir_path)
      
      puts 'What would you like to name your file?'
      file_name = gets.chomp.downcase.to_s + ".yaml"
      Dir.chdir(dir_path) do
        file = File.new(file_name, 'w')
        YAML.dump(self, file)
      end
      exit_game
    end
    
    def load_game(input: nil)
      loop do
        puts 'Would you like to load a previous game? (Y/N)'
        input = gets.chomp.downcase.to_sym unless input == :y || input == :n
        return if input == :n
        break if input == :y
      end
      
      
      dir_path = File.expand_path(File.dirname(__FILE__)).split("lib").first
      load_path = Dir[dir_path + DIRNAME + "*.yaml"]
      load_path.each { |file| puts file }
      # Ensures the file exists
      if load_path.empty?
        puts "You do not have any saved games."
        return
      end
      
      # puts 'Which file would you like to load?'
      
      # Makes sure the file being loaded has proper YAML
      begin
        Psych.load_file(File.new(load_path, 'r')).play
      rescue Psych::SyntaxError => ex
        ex.file
        ex.message
      end
    end
    
    def print_game
      # system 'clear'
      @board.print_board
      puts "safe words are: #{Game::SAFE_WORDS}"
      puts "To move a piece, enter the piece coordinate followed by destination"
      puts "IE: a2 to a4; f7 to f5"
    end
    
    def take_turn
      player = get_player_turn
      
      @board.reset_pawn_double_move(side: player.side)
      
      puts "\nIt is your turn #{player.name}"
      puts "You are #{player.side}"
      
      move_piece(player: player)
      swap_turn
      
    end
    
    def move_piece(player:, input: nil)
      loop do
        input = get_input
        # if sanitized input return nil, invalid input, repeat
        next if input.nil?
        break if input == :castled
        
        moving_piece = @board.piece(pos: input[0])
        # checks to make sure its a valid piece
        if moving_piece.nil? || !(player.pieces.include?(moving_piece))
          puts 'Please enter a valid piece to move'
          next
        end
        
        end_pos = input[1]
        move = moving_piece.move_to(pos: end_pos, board: @board)
        # if the move is not valid will repeat loop
        next if move.nil?
        break
      end
    end
    
    def get_player_turn
      return player_1 if @turn == :red
      return player_2 if @turn == :blue
    end
    
    def swap_turn
      return @turn = :red if @turn == :blue
      @turn = :blue
    end
    
    def add_player(name: nil)
      puts "What is your name?" if @players.empty?
      puts "What is player2's name?" unless @players.empty?
      name ||= gets.chomp
      @players << Player.new(name: name)
    end
    
    def add_computer_or_player(player: nil, input: nil)
      loop do
        puts "Would you like to play against a computer? (Y/N)"
        input = gets.chomp.to_sym unless input == :y || input == :n
        # Adds a computer
        # To be implemented later
        break if input == :y
        
        add_player(name: player) if input == :n
        break if input == :n
      end
    end
    
    def castle_game(direction: nil)
      player = get_player_turn
      if player.has_castled?
        puts 'You already castled once!'
        return nil
      end
      
      puts "Which direction would you like to castle? left or right?"
      direction = gets.chomp.downcase.to_sym
      king = player.get_king
      castled = king.castle(direction: direction, board: @board)
      
      return nil if castled.nil?
      
      player.has_castled = true
      :castled
    end
  end
end