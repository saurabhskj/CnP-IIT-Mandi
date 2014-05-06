class Student < User
  # attr_accessible :title, :body
  has_many :stud_comp_regs, foreign_key: :student_id
  has_many :companies, through: :stud_comp_regs

  has_many :resumes, foreign_key: :student_id
end
