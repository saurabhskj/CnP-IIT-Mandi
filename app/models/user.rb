class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :contact_info, :foreign_key => :user_id, :dependent => :delete

  belongs_to :category
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :type, :first_name, :middle_name, :last_name,
                  :dob, :gender, :hostel_name, :hostel_address, :city, :state, :perm_citz_of_india, :category_id
  # attr_accessible :title, :body
 # before_create :check_name

  def check_name
    if self.name.nil?
      self.name = 'User'
    end
  end
  
end