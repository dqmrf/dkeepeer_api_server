class User < ApplicationRecord
  has_secure_password

  before_create :confirmation_token

  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true
  
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

    def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end
