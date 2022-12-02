class CreateAllowances < ActiveRecord::Migration
  def change
    create_table :allowances do |t|
      t.references :group, index: true
      t.references :training_session, index: true

      t.timestamps
    end
  end
end
