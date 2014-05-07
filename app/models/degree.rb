class Degree < ActiveRecord::Base
  attr_accessible :duration, :name

  has_many :stud_degree_info, :foreign_key => :degree_id, :dependent => :delete_all
  validates_uniqueness_of :name
end
