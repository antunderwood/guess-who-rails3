class MessagesController < ApplicationController
  def  index
    # @undisplayed_messages = Message.undisplayed(params[:game_id],params[:player_id])
    @undisplayed_messages = Message.undisplayed(138,275)
  end
  def new
    message = Message.new(params[:message])
    message.save
    player = Player.find(message.player_id)
    player.last_message_displayed_id = message.id
    player.save
    @message_content = message.content
  end

end
