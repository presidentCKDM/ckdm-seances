class RemoveGroupNesting < ActiveRecord::Migration
  def change
  	remove_column :groups, :parent_id
  end
end
