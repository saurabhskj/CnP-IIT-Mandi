class ContactInfo < ActiveRecord::Base
  attr_accessible :college_email, :personal_email, :phone_number1, :phone_number2, :user_id

  belongs_to :user

  validates_uniqueness_of :user_id
end
