class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.integer :upvotes, :default => 0
      t.belongs_to :user
      t.timestamps
    end
  end
end
