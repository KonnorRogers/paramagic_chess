module ParamagicChess
  class Game
    SAFE_WORDS = [:save, :load, :castle, :exit]
    
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
        take_turn
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
      return true if check_mate?
      false
    end
    
    def player_1
      @players[0]
    end
    
    def player_2
      @players[1]
    end
    
    def get_input(input: nil)
      input ||= gets.chomp
      # checks for safewords
      send((input + '_game')) if SAFE_WORDS.include?(input.to_sym)
      
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
    end
    
    def load_game(input: nil)
      loop do 
        input = gets.chomp.downcase.to_sym unless input == :y || input == :n
        return if input == :n
        break if input == :y
        puts 'Would you like to load a previous game? (Y/N)'
      end
    end
    
    def print_game
      system 'clear'
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
      input = get_input
      moving_piece = @board.piece(pos: input[0])
      end_pos = @board.tile(pos: input[1])
      
      moving_piece.move_to(pos: end_pos)
      swap_turn
      
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
    
    def castle
    end
  end
end