class CreateTicketTagJoinTable < ActiveRecord::Migration
  def up
  	create_table :tickets_tags, :id => false do | t |
  		t.integer :ticket_id
  		t.integer :tag_id
  	end
  	
  	add_index :tickets_tags, [ :ticket_id, :tag_id ]
  	
  end

  def down
  	drop_table :tickets_tags
  end
end
