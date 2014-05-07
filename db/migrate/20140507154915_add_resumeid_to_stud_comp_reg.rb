class AddResumeidToStudCompReg < ActiveRecord::Migration
  def change
    add_column :stud_comp_regs, :resume_id, :integer
  end
end
