class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :priority, presence: true
  validates :priority, numericality: { only_integer: true }
  validates :due_date, presence: true
  validate  :due_date_cannot_be_in_the_past
  
  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "Due date can't be in the past")
    end
  end
end
