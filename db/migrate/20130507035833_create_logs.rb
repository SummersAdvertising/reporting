class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :actor
      t.string :controller
      t.string :action
      t.string :type
      t.text :content

      t.timestamps
    end
  end
end
