class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :name, :location, :status, :email
      t.integer :cohort_id
      t.timestamps
    end
  end
end
