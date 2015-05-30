class NearbyMailer < MandrillMailer::TemplateMailer
  include Rails.application.routes.url_helpers

  def pin_notify pin
    neighbours = User.near([pin.latitude, pin.longitude], 1).map{|u| { email: u.email, name: u.name }}.uniq

    mandrill_mail template: 'meet-your-street-new-pin',
                  subject: "Ein neuer Eintrag auf meetyourstreet in deiner Nachbarschaft",
                  to: neighbours,
                  from: "noreply@meetyourstreet.ch",
                  from_email: "noreply@meetyourstreet.ch",
                  from_name: "Meet Your Street",
                  text: "Hi von Meet Your Street! Ein neuer Eintrag wurde in deiner Nachbarschaft erstellt. Schau ihn dir an!",
                  view_content_link: pin_url(pin),
                  important: true
  end

  def user_notify user
    neighbours = User.near([user.latitude, user.longitude], 1).map{|u| { email: u.email, name: u.name }}.uniq

    mandrill_mail template: 'meet-your-street-new-neighbour',
                  subject: "Ein neuer Nachbar hat sich registriert",
                  to: neighbours,
                  from: "noreply@meetyourstreet.ch",
                  from_email: "noreply@meetyourstreet.ch",
                  from_name: "Meet Your Street",
                  text: "Hi von Meet Your Street! #{user.name} hat sich grad als neuer neuer Nachbar registriert.",
                  view_content_link: root_url,
                  important: true
  end
end