class AdminMailer < ActionMailer::Base
  default from: "noreply@meetyourstreeet.ch"
  default to: "mathias.menzl@gmail.com"

	def new_user(user)
		@user = user
		mail(subject: "New User: #{user.email}")
	end
end
