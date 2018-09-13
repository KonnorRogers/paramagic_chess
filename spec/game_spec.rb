module ParamagicChess
  RSpec.describe Game do
    let(:game) { Game.new }
    
    context '#initialize' do
      it 'creates a board' do
        expect(game.board).to be_an_instance_of Board
      end
      
      it 'creates an empty array for players' do
        expect(game.players).to be_empty
      end
      
      it 'has an array of safe words' do
        safe_words = %i{save load castle exit piece_info}
        expect(Game::SAFE_WORDS).to match_array safe_words
      end
    end
    
    context '#add_players(player1, player2, input)' do
      it 'will add only 1 player if playing against computer' do
        game.add_players(player1: 'konnor', input: :y)
        expect(game.players[0].name).to eq 'konnor'  
        expect(game.players[1]).to eq nil
      end
      
      it 'will add both players with input of :n' do
        game.add_players(player1: 'konnor', player2: 'evelyn', input: :n)
        expect(game.players[0].name).to eq 'konnor'
        expect(game.players[1].name).to eq 'evelyn'
      end
    end
    
    context '#update_movable_pieces(player:)' do
      it 'provides all 16 pieces from start of game' do
        game.players << Player.new(name: 'konnor', side: :red)
        game.update_pieces(player: game.player_1)
        expect(game.player_1.pieces.size).to eq 16
      end
      
      it 'provides 16 piece for blue' do
        game.players << Player.new(name: 'konnor', side: :blue)
        game.update_pieces(player: game.player_1)
        expect(game.player_1.pieces.size).to eq 16
      end
    end
    
    context '#get_input(input:)' do
      it 'will return the array of the 2 inputs given' do
        ary = game.get_input(input: 'a1 to a8')
        expect(ary[0]).to eq :a1
        expect(ary[1]).to eq :a8
      end
      
      it 'will return nil if improper input given' do
        expect(game.get_input(input: 'a12 f d a4 to ')).to eq nil
      end
      
      it 'will return nil if > 8' do
        expect(game.get_input(input: 'a9 to a7')).to eq nil
      end
      
      it 'will return nil if letter is not part of char_to_num' do
        expect(game.get_input(input: 'q8 to q4')).to eq nil
      end
    end
  end
end
