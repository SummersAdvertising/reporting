class ChangePriorityInTickets < ActiveRecord::Migration
  def change
  	change_column :tickets, :priority, :string, :default => "medium"
  end
end
