class CreateStudCompRegs < ActiveRecord::Migration
  def change
    create_table :stud_comp_regs do |t|
      t.integer :company_id
      t.integer :student_id
      t.boolean :shortlisted
      t.boolean :selected
      t.boolean :placed

      t.timestamps
    end
  end
end
