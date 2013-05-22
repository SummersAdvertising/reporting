class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :ticket_id
      t.string :actor
      t.text :comment
      t.string :type
      t.string :status

      t.timestamps
    end
  end
end
