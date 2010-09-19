class AddLastMessageDisplayedToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :last_message_displayed_id, :integer
  end

  def self.down
    remove column :players, :last_message_displayed_id
  end
end
