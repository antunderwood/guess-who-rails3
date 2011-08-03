class Game < ActiveRecord::Base
  has_many :players
  has_many :messages
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
#

