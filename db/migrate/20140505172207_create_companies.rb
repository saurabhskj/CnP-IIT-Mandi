class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :location
      t.string :job_type
      t.string :category
      t.string :profile
      t.integer :requirement

      t.timestamps
    end
  end
end
