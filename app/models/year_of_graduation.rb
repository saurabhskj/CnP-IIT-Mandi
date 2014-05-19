class YearOfGraduation < ActiveRecord::Base
  attr_accessible :year
  has_many :students, foreign_key: :year_of_graduation_id

end
