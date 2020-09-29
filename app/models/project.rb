class Project < ApplicationRecord
    has_many :assignments
    has_many :programmers, through: :assignments

    enum status: ['PLANNING', 'IN_PROGRESS', 'COMPLETED', 'OVERDUE']

    validates :name, presence: true, uniqueness: true
    validates :due_date, :status, presence: true
    validates :description, length: {minimum: 20}

    def format_created_at
        self.created_at.strftime("%B %e, %Y at %l:%M%p")
    end

    def format_updated_at
        self.created_at.strftime("%B %e, %Y at %l:%M%p")
    end
end
