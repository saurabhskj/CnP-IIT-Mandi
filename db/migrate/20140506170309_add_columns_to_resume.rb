class AddColumnsToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :name, :string
    add_column :resumes, :student_id, :integer

    #add_index :resumes, [:student_id, :name]  , :unique => true

  end
end
