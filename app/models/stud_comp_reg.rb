class StudCompReg < ActiveRecord::Base
  attr_accessible :company_id, :placed, :selected, :shortlisted, :student_id

  belongs_to :student, :class_name => 'Student'
  belongs_to :company, :class_name => 'Company'

  def self.create_registration(student_id, company_id)
    StudCompReg.create(student_id: student_id, company_id: company_id, shortlisted: true)
  end
end
