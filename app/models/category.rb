class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :users, :foreign_key => :category_id
end
