class Company < ActiveRecord::Base
  attr_accessible :category, :job_type_id, :location, :name, :profile, :requirement, :arrival_date

  has_many :stud_comp_regs, foreign_key: :company_id, :dependent => :destroy
  has_many :students, through: :stud_comp_regs

  belongs_to :job_type
  validates_uniqueness_of :name, :scope => :job_type_id

  def self.search(name, job_type)
    if name
      find(:all, :conditions => ['name LIKE ? AND job_type LIKE ?', "#{name}%", "#{job_type}"])
    else
      find(:all, :conditions => ['job_type LIKE ?', "#{job_type}"])
    end
  end

end
