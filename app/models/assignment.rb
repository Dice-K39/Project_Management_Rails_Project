class Assignment < ApplicationRecord
    has_many :comments, dependent: :destroy
    
    belongs_to :programmer
    belongs_to :project

    validates :task, :assigned_at, presence: true
    validates :is_completed, default: false

    def full_name
        self.programmer.first_name + ' ' + self.programmer.last_name
    end

    def completed?
        if self.is_completed
            'YES'
        else
            'NO'
        end
    end

    def self.assignment_search(query)
        self.where('task LIKE ?', "%#{query}%")
    end
end
