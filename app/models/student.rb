class Student < User
  # attr_accessible :title, :body
  has_many :stud_comp_regs, foreign_key: :student_id, :dependent => :destroy
  has_many :companies, through: :stud_comp_regs

  has_many :resumes, foreign_key: :student_id, :dependent => :destroy

  has_one :stud_degree_info, :foreign_key => :student_id, :dependent => :destroy

  after_create :create_details

  def create_details
    ContactInfo.create(user_id: self.id)
    StudDegreeInfo.create(student_id: self.id)
    %x(mkdir lib/resumes/"#{self.id}")
  end

  def self.search(name)
    if name.nil? == false and name.empty? == false
      find(:all, :conditions => ['first_name LIKE ?', "%#{name}%"])
    else
      find(:all)
    end
  end

end
