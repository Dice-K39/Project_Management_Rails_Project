class Assignment < ApplicationRecord
    has_many :comments
    
    belongs_to :programmer, optional: true
    belongs_to :project, optional: true

    validates :task, :assigned_at, :is_completed, presence: true

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
