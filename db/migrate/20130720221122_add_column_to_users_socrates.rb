class AddColumnToUsersSocrates < ActiveRecord::Migration
  def change
    add_column :users, :socrates_auth, :boolean, :default => false
  end
end
