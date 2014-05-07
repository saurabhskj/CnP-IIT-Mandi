class Branch < ActiveRecord::Base
  attr_accessible :name

  has_many :stud_degree_infos, :foreign_key => :branch_id, dependent: :delete_all
end
