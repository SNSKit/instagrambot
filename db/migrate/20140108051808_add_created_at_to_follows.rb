class AddCreatedAtToFollows < ActiveRecord::Migration
  def change
    add_column :follows, :created_at, :datetime
  end
end
