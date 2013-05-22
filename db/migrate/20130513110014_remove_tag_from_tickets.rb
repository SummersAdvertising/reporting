class RemoveTagFromTickets < ActiveRecord::Migration
  def up
  	remove_column :tickets, :tag
  end

  def down
  	add_column :tickets, :tag, :string
  end
end
