class AddFollowAbilityToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :enable_following, :boolean, default: false
  end
end
