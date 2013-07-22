class CreateUpvotes < ActiveRecord::Migration
  def change
    remove_column :topics, :upvotes
    create_table :upvotes do |t|
      t.belongs_to :user
      t.belongs_to :topic
    end
    add_index :upvotes, [:user_id, :topic_id], :unique => true
  end
end
