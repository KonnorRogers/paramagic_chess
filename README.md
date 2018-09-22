# ParamagicChess

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/paramagic_chess`. To experiment with that code, run `bin/console` for an interactive prompt.

This a game of chess created as the final project of TheOdinProject. The rules used are based off of Wikipedia's ruleset to
include en_passant, castling, as well as saving and loading. The game is to be played in a terminal. Tested w/ Ruby 2.5.1 on a ubuntu 18.04 / 16.04 machine.
The game also includes saving / loading as well as RSpec testing. The only dependencies are 
Bundler, RSpec & Rake which are all part of keeping the same environment across different development platforms.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paramagic_chess'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paramagic_chess

## Usage

Usage is as follows:
    git clone https://github.com/ParamagicDev/paramagic_chess.git
    cd /path/to/paramagic_chess
    ruby lib/paramagic_chess.rb

A prompt will pop up asking if you would like to load a previous game.
A game can be saved at any time by typing 'save' into the terminal.
A prompt will appear as to how you would like to save the game. 
Games will be saved to a saved_games directory

Pieces are moved via 'a2 to a4'
typing 'piece_info' will show a prompt which will ask for coordinates of the piece you would like to know about
There are other safe words which are save, load, castle, & exit
castle will give you the option to castle right or castle left
Pieces are only allowed to make legal moves to include en_passant, and cannot make a move which will put them
in check or checkmate

Tests can be run via navigating to paramagic_chess.rb & commenting out the ParamagicChess::Game.new.play
And then running '$ rspec' or '$ rake spec'

Computer AI has not been implemented yet. It will be in the future. Will be super simple and will
just do a random legal move

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/paramagicdev/paramagic_chess. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ParamagicChess project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/paramagic_chess/blob/master/CODE_OF_CONDUCT.md).
