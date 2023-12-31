class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, authentication_keys: [:email_or_username]

  include DeviseTokenAuth::Concerns::User

  attr_writer :email_or_username

  def email_or_username
    @email_or_username || email || username
  end

  def self.find_for_database_authentication(condition)
    find_by('lower(username) = :value OR lower(email) = :value', { value: condition[:email_or_username] })
  end
end
