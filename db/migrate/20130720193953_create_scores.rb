class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :specific, :actionable, :kind
      t.belongs_to :user
      t.belongs_to :topic
      t.timestamps
    end
    add_index :scores, [:user_id, :topic_id], :unique => true
  end
end
