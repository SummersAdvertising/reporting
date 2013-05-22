class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.timestamp :deadline
      t.string :period
      t.string :reporter
      t.text :treatment
      t.timestamp :close_time
      t.string :topic
      t.string :status

      t.timestamps
    end
  end
end
