class ChangeCcInTickets < ActiveRecord::Migration
  def change
  	change_column :tickets, :cc, :text, :default => "[]"
  end
end
