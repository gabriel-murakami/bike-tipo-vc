# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :trips
  has_many :bills
  has_one :bike

  validates :due_date, inclusion: 1..31

  after_create { SendBillingNotificationWorker.perform_at(date, self.due_date, self.id) }

  private

  def date
    (Date.new(Date.current.year, Date.current.month, self.due_date) + 1.month).to_s
  end
end
