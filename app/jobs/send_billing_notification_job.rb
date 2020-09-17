# frozen_string_literal: true

class SendBillingNotificationJob < ApplicationJob
  queue_as 'bike-tipo-vc.job.send-billing-notification'

  def perform(users)
    users.each do |user|
      bill = Bill.new(user: user, value: value(user), expires_at: 1.month.since)

      deliver_email(bill) if bill.save!
    end
  end

  private

  def deliver_email(bill)
    BillingMailer.with(bill: bill).new_billing.deliver_now
  end

  def value(user)
    Pricing::BillingValueService.new(user: user).execute
  end
end
