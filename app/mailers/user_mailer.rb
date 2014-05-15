class UserMailer < ActionMailer::Base
  default from: "c@saurabhj.net"
  # before_filter :email_notifications_on?

  private
  def email_notifications_on?
    if current_student
      true
    end
  end

  public
  def welcome_email(student)
    @student = student
    @url = 'localhost:3000/student/sign_in'
    mail(to: @student.email, subject: 'Welcome to Training and Placement Cell, IIT Mandi.')
  end

  def notify_email(student_id, subject, message)
    @student= Student.find(student_id)
    @message = message
    @url = 'http://localhost:3000/student/sign_in'
    @email_with_name = "#{@student.first_name} <#{@student.email}>"
    mail(to: @email_with_name, subject: subject)
  end

end
