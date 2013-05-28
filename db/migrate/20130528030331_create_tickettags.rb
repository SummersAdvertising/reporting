class CreateTickettags < ActiveRecord::Migration
  def change
    create_table :tickettags do |t|
      t.integer :ticket_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
