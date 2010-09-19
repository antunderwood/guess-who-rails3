class Message < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  
  attr_accessible :message_type, :content, :game_id, :player_id
  
  scope :undisplayed, lambda {|game_id, player_id| where("game_id = :game_id AND id > :id", :game_id => game_id, :id => Player.find(player_id).last_message_displayed_id ) }
end
