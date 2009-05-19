class Notifications < ActionMailer::Base
 
  def forgot_password(to, login, pass, sent_at = Time.now)
    @subject = "Your new password for JGC website"
    @body['login']=login
    @body['pass']=pass
    @recipients = to
    @from = 'helpjgc@gmail.com'
    @sent_on = sent_at
    @headers = {}
  end
  
  def send_notice(to, org, user, sent_at = Time.now)
    @subject = "New organization has been created "
    @body['org']=org
    @body['user']=user
    @recipients = to
    @from = 'helpjgc@gmail.com'
    @sent_on = sent_at
    @headers = {}
  end
  def new_user(to,user, email, sent_at = Time.now)
    @subject = "New User has joined the network "
    @body['user']=user
    @body['email']=email
    @recipients = to
    @from = 'helpjgc@gmail.com'
    @sent_on = sent_at
    @headers = {}
  end
  
  def send_mail(to,from,mail,subject, sent_at = Time.now)
    @subject = subject
    @body = mail
    @recipients = to
    @from = from
    @sent_on = sent_at
    @headers = {}
  end
  
end

  
