class Emails < ActiveRecord::Base
  def self.checkMail
    @email_id = Emails.find_by_sql ["SELECT * from emails"];
    if @email_id
      return 1
    else
      return 0
    end
  end
  
  def self.sendMail
    
      @email_id = Emails.find_by_sql ["SELECT * from emails"];
      for email in @email_id
        Notifications.deliver_send_mail(email.to,email.from,email.mail,email.subject)
        Emails.delete(email.id)
      end
  end
  
end
