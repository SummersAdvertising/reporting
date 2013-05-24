class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :status
      t.integer :count
      t.string :color

      t.timestamps
    end
  end
end
