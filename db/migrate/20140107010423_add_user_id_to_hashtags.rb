class AddUserIdToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :user_id, :string
  end
end
