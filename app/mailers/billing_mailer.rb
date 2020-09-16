# frozen_string_literal: true

class BillingMailer < ApplicationMailer
  def new_billing
    @bill = params[:bill]

    mail(to: @bill.user.email, subject: "Sua fatura chegou!")
  end
end
