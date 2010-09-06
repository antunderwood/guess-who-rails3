class GamesController < ApplicationController
   before_filter :authenticate_user!, :only => :new
   before_filter :game_accessible?, :only => :show
  def new
   
  end
  
  def create
    @game = Game.new
    @game.state = "waiting_for_both_player_login"
    @game.first_turn = params[:first_turn]
    @game.password = generate_password(8)
  
    player1 = Player.new
    player1.name = params[:player1_name]
    player1.chosen_card = rand(24)
    player1.game = @game
    
    @player = player1
    
    player2 = Player.new
    player2.name = params[:player2_name]
    player2.chosen_card = rand(24)
    until player2.chosen_card != player1.chosen_card
      player2.chosen_card = rand(24)
    end
    player2.game = @game

    Game.transaction do
      @game.save
      player1.save
      player2.save
    end
    render :show
  end

  def show
    #@player will be defined if we have come to the show action after game#create, otherwose the player will be player2 which is the last of the players created for the game
    @player ||= @game.players.last
  end
  
  private
  def generate_password(len = 8 )
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    password = ""
    1.upto(len) { |i| password << chars[rand(chars.size-1)] }
    return password
  end
  def game_accessible?
    if @game.nil?
      @game = Game.find(params[:id])
      if @game.password != params[:password]
        flash[:error] = "You do not have permissions to access that game. If you would like to start a new game please fill in the details below"
        redirect_to root_path
      end
    end
  end

end
