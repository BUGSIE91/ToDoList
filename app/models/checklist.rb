class Checklist < ApplicationRecord

  belongs_to :user

  validates :task_name, presence: true, length: {minimum: 5}
  validates :priority, presence: true, :inclusion => {:in => %w(High Medium Low)}

  def self.get_checklist_entries(user)
    user.checklists
  end

end
