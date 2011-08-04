class Game < ActiveRecord::Base
  has_many :players
  has_many :messages
  belongs_to :user
  
  WORDS = ["a", "head","mouth","eye","eyes","nose","eyes on stalks","skin","one","two","three","blue","green","orange","spotty","squiggly","circular","oval","triangular","happy","sad"]
end


# == Schema Information
#
# Table name: games
#
#  id         :integer         not null, primary key
#  password   :string(255)
#  state      :string(255)
#  first_turn :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

