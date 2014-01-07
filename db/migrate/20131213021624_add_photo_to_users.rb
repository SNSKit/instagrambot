class AddPhotoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :picture, :text
  end
end
