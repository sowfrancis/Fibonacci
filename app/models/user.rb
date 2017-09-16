class User < ApplicationRecord
  include Clearance::User
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validate :validate_password
  validates_presence_of :email, :firstname, :lastname, :number, :street, :zip, :city

  def validate_password
    if !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./)
      errors.add :password, 'must include at least one lowercase letter, one uppercase letter, and one digit'
    end
  end
end
