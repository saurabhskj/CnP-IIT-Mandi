class Company < ActiveRecord::Base
  attr_accessible :category, :job_type, :location, :name, :profile, :requirement

  has_many :stud_comp_regs, foreign_key: :company_id
  has_many :students, through: :stud_comp_regs

  validates_uniqueness_of :name

  def self.search(name)
    if name
      find(:all, :conditions => ['name LIKE ?', "#{name}%"])
    else
      find(:all)
    end
  end

end
