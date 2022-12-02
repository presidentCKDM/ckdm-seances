class SwitchGroupToMemberships < ActiveRecord::Migration
  def change
  	User.all.each do |user|
  		group = Group.find user.group_id

  		user.groups << group
  		puts "---- #{group} added to #{user}"
  		user.save
  	end

  	remove_column :users, :group_id

  end
end
