class CreateStudDegreeInfos < ActiveRecord::Migration
  def change
    create_table :stud_degree_infos do |t|
      t.integer :student_id
      t.integer :degree_id
      t.integer :branch_id
      t.integer :year_of_grad
      t.string :enrolment_number

      t.timestamps
    end
  end
end
