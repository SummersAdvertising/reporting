class ChangeTicketsTopicColumnName < ActiveRecord::Migration
  def change
  	rename_column :tickets, :topic, :topic_id
  end
end
