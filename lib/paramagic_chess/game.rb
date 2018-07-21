module ParamagicChess
  class Game
    SAFE_WORDS = [:save, :load, :castle]
    
    attr_reader :board, :players
    
    def initialize
      @board = Board.new
      @players = []
    end
    
    # player1, player2, and input all added for testing purposes
    def add_players(player1: nil, player2: nil, input: nil)
      add_player(name: player1)
      add_computer_or_player(player: player2, input: input)
    end
    
    def play
      greeting_message
      add_players
      randomize_sides
      
      loop do
        
      end
    end
    
    def randomize_sides
      @players.shuffle!
      @players[0].side = :red
      @players[1].side = :blue
    end
    
    def greeting_message
      system 'clear'
      puts "Welcome to ParamagicChess. Theres nothing magical here \n
            Just Chess."
      puts "If you would like to start from a previously
            saved game, type 'load'"
    end
    
    def game_over?
      return true if check_mate?
      false
    end
    
    private
    
    def add_player(name: nil)
      puts "What is your name? \n"
      name ||= gets.chomp
      @players << Player.new(name: name)
    end
    
    def add_computer_or_player(player: nil, input: nil)
      loop do
        puts "Please enter Y/N to play against a computer"
        input ||= gets.chomp.to_sym
        break if input == :y
        # Adds a computer
        # To be implemented later
        
        add_player(name: player) if input == :n
        break if input == :n
      end
    end
    
    def check?
    end
    
    def check_mate?
    end
    
    def castle
    end
    
    def input(input: gets.chomp)
      SAFE_WORDS.include?(input.to_sym)
    end
  end
end