class Project < ApplicationRecord
    has_many :assignments
    has_many :programmers, through: :assignments

    enum status: ['PLANNING', 'IN_PROGRESS', 'COMPLETED', 'OVERDUE']

    validates :name, presence: true, uniqueness: true
    validates :due_date, :status, presence: true
    validates :description, length: {minimum: 20}
end
