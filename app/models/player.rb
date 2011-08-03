class Player < ActiveRecord::Base
  belongs_to :game
  has_many :messages
end

# == Schema Information
#
# Table name: players
#
#  id                        :integer         not null, primary key
#  game_id                   :integer
#  name                      :string(255)
#  chosen_card               :integer
#  created_at                :datetime
#  updated_at                :datetime
#  last_message_displayed_id :integer
#

