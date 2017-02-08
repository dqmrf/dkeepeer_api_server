class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true
  
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
