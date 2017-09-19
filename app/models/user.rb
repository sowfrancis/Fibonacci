class User < ApplicationRecord
  include AASM
  include Clearance::User
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :validate_password
  validates_presence_of :email, :firstname, :lastname, :number, :street, :zip, :city
  has_one :situation, dependent: :destroy
  has_one :technical_info, dependent: :destroy
  accepts_nested_attributes_for :situation, allow_destroy: true
  accepts_nested_attributes_for :technical_info, allow_destroy: true

  def validate_password
    if first_step? && password.present?
      if !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./)
        errors.add :password, 'must include at least one lowercase letter, one uppercase letter, and one digit'
      end
    end
  end

  aasm do
    state :first_step, initial: true
    state :second_step
    state :completed

    after_all_transitions :send_email

    event :filled_first_form do
      transitions from: :first_step, to: :second_step
    end

    event :filled_second_form do
      transitions from: :second_step, to: :completed
    end

    event :modify_first_form do
      transitions from: :second_step, to: :first_step
    end

    event :last_step do
      transitions from: [:first_step, :second_step], to: :completed
    end
  end

  def send_email
    UserMailer.email_after_sign_up(self)
  end
end
