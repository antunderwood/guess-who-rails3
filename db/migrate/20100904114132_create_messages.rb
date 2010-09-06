class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :game_id
      t.integer :player_id
      t.string :type
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
