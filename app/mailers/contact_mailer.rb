class ContactMailer < ApplicationMailer
  def contact_mail(contact,user)
    @contact = contact
    mail to: user.email, subject: "お問い合わせの確認メール"
  end
end
