class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.string :user_id
      t.string :followed_id
    end
  end
end
