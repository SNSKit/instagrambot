class CreateUsernames < ActiveRecord::Migration
  def change
    create_table :usernames do |t|
      t.string :user_id, :string
      t.string :username, :string
      t.timestamps 
    end
  end
end
