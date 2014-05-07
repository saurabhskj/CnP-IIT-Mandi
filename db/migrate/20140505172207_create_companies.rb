class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :location
      t.integer :job_type_id
      t.string :category
      t.string :profile
      t.integer :requirement

      t.timestamps
    end

    add_index :companies, [:name, :job_type_id], :unique => true
  end
end
