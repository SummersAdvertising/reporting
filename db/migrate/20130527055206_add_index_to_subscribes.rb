class AddIndexToSubscribes < ActiveRecord::Migration
  def self.up
    add_index :subscribes, :user_id
  end

  def self.down
    remove_index :subscribes, :column => :user_id
  end
end
