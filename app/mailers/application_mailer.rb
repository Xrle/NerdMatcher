class ApplicationMailer < ActionMailer::Base
  default to: 'info@nerdmatcher.com', from: 'info@nerdmatcher.com'
  layout 'mailer'
end
