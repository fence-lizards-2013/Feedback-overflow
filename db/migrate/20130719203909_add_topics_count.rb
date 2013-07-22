class AddTopicsCount < ActiveRecord::Migration
  def change
    add_column :topics, :upvotes_count, :integer, :default => 0
  end
end
