class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.text :content

      t.timestamps
    end
  end
end
