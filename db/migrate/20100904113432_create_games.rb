class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :password
      t.string :state
      t.integer :first_turn

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
