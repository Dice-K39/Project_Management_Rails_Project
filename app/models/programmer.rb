class Programmer < ApplicationRecord
    has_secure_password
    
    has_many :assignments
    has_many :projects, through: :assignments
    has_many :comments

    validates :username, :email, presence: true, uniqueness: true
    validates :password, :first_name, :last_name, presence: true
    validates :phone_number, presence: true, length: {is: 10}
    validates :is_project_manager, default: false

    def full_name
        self.first_name + ' ' + self.last_name
    end

    def format_created_at
        self.created_at.strftime("%B %e, %Y at %l:%M%p")
    end

    def format_updated_at
        self.updated_at.strftime("%B %e, %Y at %l:%M%p")
    end

    def format_last_login
        self.last_login.strftime("%B %e, %Y at %l:%M%p")
    end

    def self.programmer_search(query)
        self.where('first_name LIKE ?', "%#{query}%")
    end
end
