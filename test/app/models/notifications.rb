class Notifications < ActionMailer::Base
  def forgot_password(to, login, pass, sent_at = Time.now)
    @subject    = "Your new password for JGC website"
    @body['login']=login
    @body['pass']=pass
    @recipients = to
    @from       = 'supportjgc@gmail.com'
    @sent_on    = sent_at
    @headers    = {}
  end
end

  
