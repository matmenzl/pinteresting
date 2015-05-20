class NearbyMailer < MandrillMailer::MessageMailer
  include Rails.application.routes.url_helpers
  default from: "noreply@meetyourstreet.ch"

  def pin_notify pin
    neighbours = User.near([pin.latitude, pin.longitude], 1).map{|u| { email: u.email, name: u.name }}.uniq

    mandrill_mail subject: "New pin was posted nearby.",
                  to: neighbours,
                  # to: invitation.email,
                  # to: { email: invitation.email, name: 'Honored Guest' },
                  text: "Hi from Meet Your Street! A new pin was created near your location. Check it out now!",
                  view_content_link: pin_url(pin),
                  important: true
  end

  def user_notify user
    neighbours = User.near([user.latitude, user.longitude], 1).map{|u| { email: u.email, name: u.name }}.uniq
    
    mandrill_mail subject: "Is this your neighbour?",
                  to: neighbours,
                  # to: invitation.email,
                  # to: { email: invitation.email, name: 'Honored Guest' },
                  text: "Hi from Meet Your Street! #{user.name} has just registered near your location. Is this your neighbour?",
                  view_content_link: root_url,
                  important: true
  end
end