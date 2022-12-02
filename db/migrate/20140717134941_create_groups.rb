class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.references :parent, index: true

      t.timestamps
    end

    add_column :users, :group_id, :integer
    add_index :users, :group_id
  end
end
