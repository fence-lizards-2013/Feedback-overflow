class AddColumnNameSlugToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name_slug, :string
  end
end
