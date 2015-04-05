class PinsContact < ActionMailer::Base
  default to: "mathias.menzl@gmail.com"

  def owner(sender, recipient, body)
    @body = body

    mail(to: recipient, subject: "New Question from meinenachbarn.ch!", from: sender)
  end

  def share(sender, recipient, pin_id)
    @pin = Pin.find(pin_id)
    @sender = sender
    mail(to: recipient, subject: "#{@sender.name} shared a pin with you from meinenachbarn.ch!", from: @sender.email)
  end
end
