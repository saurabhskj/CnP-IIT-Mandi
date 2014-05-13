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
    @url = 'localhost:3000/students/sign_in'
    mail(to: @student.email, subject: 'Welcome to My Web App.')
  end

end
