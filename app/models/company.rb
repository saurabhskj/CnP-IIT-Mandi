class Company < ActiveRecord::Base
  attr_accessible :category, :job_type, :location, :name, :profile, :requirement

  validates_uniqueness_of :name

  def self.search(name)
    if name
      find(:all, :conditions => ['name LIKE ?', "#{name}%"])
    else
      find(:all)
    end
  end

end
