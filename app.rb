require 'sinatra/base'
require './lib/player.rb'
require './lib/game.rb'
require './lib/computer.rb'

class RockPaperScissors < Sinatra::Base
  # enable :sessions
  # set :session_secret, 'string'

  get '/' do
    erb :registration
  end

  post '/name' do
    $game = Game.new(Player.new(params[:player_1_name]), Computer.new)
    @game = $game
    redirect '/play'
  end

  get '/play' do
    @player1 = $game.player.name
    erb :play
  end

  post '/selection' do
    $player1_choice = $game.player.choose_weapon(params[:player_1_choice])
    redirect 'result'
  end

  get '/result' do
    @player1_choice = $player1_choice
    @computer_choice = $game.computer.weapon
    erb :result
  end

  run! if app_file == $0
end
