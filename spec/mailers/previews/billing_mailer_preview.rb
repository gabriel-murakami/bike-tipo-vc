# Preview all emails at http://localhost:3000/rails/mailers/billing_mailer
class BillingMailerPreview < ActionMailer::Preview
  def new_billing
    bill = Bill.last

    BillingMailer.with(bill: bill).new_billing
  end
end
