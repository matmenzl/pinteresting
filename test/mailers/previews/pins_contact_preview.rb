# Preview all emails at http://localhost:3000/rails/mailers/pins_contact
class PinsContactPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/pins_contact/owner
  def owner
    PinsContact.owner
  end

  # Preview this email at http://localhost:3000/rails/mailers/pins_contact/interest
  def interest
    PinsContact.interest
  end

end
