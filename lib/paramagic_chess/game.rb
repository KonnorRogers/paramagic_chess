module ParamagicChess
  class Game
    SAFE_WORDS = [:save, :load, :castle, :exit]
    
    attr_reader :board, :players
    
    def initialize
      @board = Board.new
      @players = []
      @turn == :red
    end
    
    # player1, player2, and input all added for testing purposes
    def add_players(player1: nil, player2: nil, input: nil)
      add_player(name: player1)
      add_computer_or_player(player: player2, input: input)
    end
    
    def play
      greeting_message
      load_game
      add_players
      randomize_sides
      
      loop do
        print_game
        take_turn
        break
      end
    end
    
    def randomize_sides
      @players.shuffle!
      @players[0].side = :red && @players[0].turn = true
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
    
    private
    
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
      reset_pawn_double_moves(side: player.side)
      
      swap_turn
    end
    
    def get_player_turn
      return player1 if @turn == :red
      return player2 if @turn == :blue
    end
    
    def swap_turn
      @turn = :red if @turn == :blue
      @turn = :blue if @turn == :red
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
    
    def input(input: gets.chomp)
      SAFE_WORDS.include?(input.to_sym)
    end
  end
end