class JobType < ActiveRecord::Base
  attr_accessible :name

  validates_uniqueness_of :name

  has_many :companies, foreign_key: :job_type_id
end
