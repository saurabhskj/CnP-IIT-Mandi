class StudDegreeInfo < ActiveRecord::Base
  attr_accessible :branch_id, :degree_id, :enrolment_number, :student_id, :year_of_grad, :cgpa

  belongs_to :student
  belongs_to :degree
  belongs_to :branch

end
