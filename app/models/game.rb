class Game < ActiveRecord::Base
  has_many :players
  has_many :messages
  belongs_to :user
  
  WORDS = ["a", "head","mouth","eye","eyes","nose","eyes on stalks","skin","one","two","three","blue","green","orange","spotty","squiggly","circular","oval","triangular","happy","sad"]
  NAMES = ["Snooz", "Zarg", "Sassle", "Gira", "Zog", "Yop", "Matag", "Pieb", "Uno", "Tonil", "Ufusi", "Veop", "Moog", "Jolod", "Pokov", "Zebo", "Hoobla", "Mush", "Gotat", "Zaphod", "Norboo", "Foobar", "Linrot", "Tag"]
  
  scope :recent, order("id DESC").limit(5)
  
  def update_state(new_state)
    self.update_attribute(:state, new_state)
    message_content = new_state.capitalize.gsub(/_/, " ")
    message_content.sub!("player1", "#{self.players.first.name}'s")
    message_content.sub!("player2", "#{self.players.last.name}'s")
    Message.create(:game_id  => self.id, :message_type  => "notification", :content => message_content)
  end
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

