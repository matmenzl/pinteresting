class PinsContact < ActionMailer::Base
  default to: "mathias.menzl@gmail.com"

  def owner(sender, recipient, body)
    @body = body

    mail(to: recipient, subject: "New Question from Pinterest!", from: sender)
  end

  def interest
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
