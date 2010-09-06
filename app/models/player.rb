class Player < ActiveRecord::Base
  belongs_to :game
  has_many :messages
end
