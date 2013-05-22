class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :status
      t.integer :count

      t.timestamps
    end
  end
end
