class CreateTicketccs < ActiveRecord::Migration
  def change
    create_table :ticketccs do |t|
      t.integer :ticket_id
      t.integer :user_id

      t.timestamps
    end
  end
end
