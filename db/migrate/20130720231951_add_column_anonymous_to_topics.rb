class AddColumnAnonymousToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :anonymous, :boolean, :default => false
  end
end
