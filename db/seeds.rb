# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_list = [
    ["admin@iitmandi.ac.in", "admin","9999"],
    ["pc@iitmandi.ac.in", "admin","9998"]
]

admin_list.each do |email, password|
  admin = Admin.new(:email => email, :password => password, :password_confirmation => password) #, name: "Saurabh")
#  admin.confirmation_token = nil
#  admin.skip_confirmation!
#  admin.skip_confirmation_notification!
  admin.save
  ContactInfo.create(user_id: admin.id)
  #admin.contact_info.build.save
end

user_list = [
    ["user@iitmandi.ac.in", "demo","9999"],
    ["saurabh@iitmandi.ac.in", "demo","9998"]
]

user_list.each do |email, password|
  user = Student.new(:email => email, :password => password, :password_confirmation => password) #, name: "User")
  #user.confirmation_token = nil
  #user.skip_confirmation!
  #user.skip_confirmation_notification!
  user.save
  ContactInfo.create(user_id: user.id)
  #user.contact_info.build.save
end

category_list = [
    "Gen", "OBC", "SC/ST", "Others"
]

category_list.each do |name|
  Category.create(name: name).save
end

job_type = ["Intern", "Full Time"]
job_type.each do |name|
  JobType.create(name: name)
end

company_list = [
    ["Amazon", "Software Development Engineer", 1, "Hyderabad", 5],
    ["Facebook", "Software Development Engineer", 2, "California", 3],
    ["Google", "Product Manager", 2, "Silicon Valley", 2],
    ["Microsoft","Security Engineer", 1, "Bangalore", 3],
    ["Tower Research","System Research", 2, "Bangalore", 2]
]

company_list.each do |name, category, job_type, location, req|
  Company.create(name: name, category: category, job_type_id: job_type, location: location, requirement: req)
end


degrees = [["B.Tech", 4], ["M.S.", 2], ["P.H.D.", 5]]

degrees.each do |name, dur|
  Degree.create(name: name, duration: dur)
end

branch_list = ["Computer Science Engineering", "Electrical Engineering", "Mechanical Engineering"]

branch_list.each do |name|
  Branch.create(name: name)
end