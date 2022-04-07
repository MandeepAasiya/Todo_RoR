class Task < ApplicationRecord
  has_event :complete

    enum priorities: {Normal: 'Normal', Medium: 'Medium', High: 'High'}

    validates_presence_of :title
    validates_length_of :title, :maximum => 40
    validates_length_of :description, :maximum => 1024

    scope :recent_tasks, ->(since_last_n_days: 3) {
        where('created_at > ?', DateTime.current - since_last_n_days.days )
    }

    scope :is_completed, -> {
        where(completed: true)
    }

    scope :is_incompleted, -> {
        where(completed: false)
    }

    scope :priority_normal, -> {
        where(priority: "Normal")
    }

    scope :priority_medium, -> {
        where(priority: "Medium")
    }

    scope :priority_high, -> {
        where(priority: "High")
    }

end
