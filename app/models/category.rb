class Category < ActiveRecord::Base
  attr_accessible :name

  validates_uniqueness_of :name

  has_many :users, :foreign_key => :category_id
end
