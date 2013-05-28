class AddCcToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :cc, :text
  end
end
