class MessagesController < ApplicationController
  def  index
    @undisplayed_messages = Message.undisplayed(params[:game_id],params[:player_id])
    if @undisplayed_messages.size > 0
      Player.find(params[:player_id]).update_attribute(:last_message_displayed_id, @undisplayed_messages.last.id)
    end
  end
  
  def create
    @message = Message.new(params[:message])
    @message.save
    player = Player.find(@message.player_id)
    player.last_message_displayed_id = @message.id
    player.save
    respond_to do |format|
      format.js
    end
  end

end
