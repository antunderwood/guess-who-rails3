class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :game_id
      t.string :name
      t.integer :chosen_card

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
