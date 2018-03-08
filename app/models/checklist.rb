class Checklist < ApplicationRecord

  # A checklist is created by the user
  belongs_to :user

  # Validations
  validates :task_name, presence: true, length: {minimum: 5}
  validates :priority, presence: true, :inclusion => {:in => %w(High Medium Low)}

  # Per page setup for will_paginate
  self.per_page = 5

  # Scope to get High Priority Tasks
  scope :get_high_priority_tasks, -> { where(priority: 'High') }
  # Scope to get finished tasks
  scope :get_completed_tasks, -> { where(completed: true) }
  # Scope to get pending tasks
  scope :get_pending_tasks, ->{ where(completed: false) }

  def self.get_checklist_entries(user)
    user.checklists
  end

end
