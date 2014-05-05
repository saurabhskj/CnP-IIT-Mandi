class Company < ActiveRecord::Base
  attr_accessible :category, :job_type, :location, :name, :profile, :requirement
  
end
