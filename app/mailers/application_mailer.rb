# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  default name: 'Bike'
  layout 'mailer'
end
