class ApplicationMailer < ActionMailer::Base
  default from: "\"David's Site\" <no-reply@example.com>"
  layout 'mailer'
end
