class Assignment < ApplicationRecord
    has_many :comments
    
    belongs_to :programmer, optional: true
    belongs_to :project, optional: true

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
end
