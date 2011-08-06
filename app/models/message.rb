class Message < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  after_create :update_game_status
  
  attr_accessible :message_type, :content, :game_id, :player_id
  
  scope :undisplayed, lambda { |game_id, player_id|
    where("game_id = :game_id AND id > :id",
          :game_id => game_id,
          :id => Player.find(player_id).last_message_displayed_id).
    order(:id)
  }
  
  def update_game_status
    case message_type
    when "chat"
      #  do nothing
    when "response"
      if self.game.state == "waiting_for_player1_response"
        self.game.update_state("waiting_for_player1_question")
      elsif self.game.state == "waiting_for_player2_response"
        self.game.update_state("waiting_for_player2_question")
      end
    when "question"
      if self.game.state == "waiting_for_player1_question"
        self.game.update_state("waiting_for_player2_response")
      elsif self.game.state == "waiting_for_player2_question"
        self.game.update_state("waiting_for_player1_response")
      end
    end
  end
end

# == Schema Information
#
# Table name: messages
#
#  id           :integer         not null, primary key
#  game_id      :integer
#  player_id    :integer
#  message_type :string(255)
#  content      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

