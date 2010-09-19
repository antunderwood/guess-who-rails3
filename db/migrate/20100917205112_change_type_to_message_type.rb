class ChangeTypeToMessageType < ActiveRecord::Migration
  def self.up
    rename_column :messages, :type, :message_type
  end
  
  def self.down
    rename_column :messages, :message_type, :type
  end
end