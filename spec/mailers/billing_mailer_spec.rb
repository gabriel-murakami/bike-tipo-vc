# frozen_string_literal: true

require "rails_helper"

RSpec.describe BillingMailer, :type => :mailer do
  describe "#new_billing" do
    let(:bill) { build(:bill) }
    subject(:mail) { described_class.with(bill: bill).new_billing }

    it "renders the headers" do
      expect(mail.subject).to eq("Sua fatura chegou!")
      expect(mail.to).to eq(["admin@bike.com"])
      expect(mail.from).to eq(["from@example.com"])
    end
  end
end
