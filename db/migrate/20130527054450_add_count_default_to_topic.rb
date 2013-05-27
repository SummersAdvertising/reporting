class AddCountDefaultToTopic < ActiveRecord::Migration
  def change
  	change_column :topics, :count, :integer, :default => 0
  end
end
