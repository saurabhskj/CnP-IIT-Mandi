class Student < User
  # attr_accessible :title, :body
  has_many :stud_comp_regs, foreign_key: :student_id, :dependent => :destroy
  has_many :companies, through: :stud_comp_regs

  has_many :resumes, foreign_key: :student_id, :dependent => :destroy

  has_one :stud_degree_info, :foreign_key => :student_id, :dependent => :destroy

  after_create :create_details

  def create_details
    ContactInfo.create(user_id: self.id)
    %x(mkdir lib/resumes/"#{self.id}")
  end

end
