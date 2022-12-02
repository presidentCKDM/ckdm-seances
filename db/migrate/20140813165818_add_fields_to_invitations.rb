class AddFieldsToInvitations < ActiveRecord::Migration
  def change
  	remove_column :invitations, :status

  	add_column :invitations, :is_answered, :boolean, default: false
  	add_column :invitations, :is_confirmed, :boolean, default: false
  end
end
