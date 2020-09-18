# frozen_string_literal: true

class SendBillingNotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(due_date, user_id)
    user = User.find(user_id)
    bill = Bill.new(user: user, value: value(user), expires_at: 7.days.since)

    deliver_email(bill) if bill.save!

    SendBillingNotificationWorker.perform_in(1.month, due_date, user_id)
  end

  private

  def deliver_email(bill)
    BillingMailer.with(bill: bill).new_billing.deliver_now
  end

  def value(user)
    Pricing::BillingValueService.new(user: user).execute
  end
end
