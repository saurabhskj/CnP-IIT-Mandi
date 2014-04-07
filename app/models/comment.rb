class Comment < ActiveRecord::Base
  belongs_to :forum
  attr_accessible :body, :commenter, :email

  validates :email, presence: true, length: {minimum: 8}
end
