class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :status
      t.references :user, index: true
      t.references :training_session, index: true

      t.timestamps
    end
  end
end
