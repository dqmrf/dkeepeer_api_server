class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  # has_one :access_token, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id
  # delegate :token, to: :access_token

  validates :email, presence: true
end
