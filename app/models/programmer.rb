class Programmer < ApplicationRecord
    has_secure_password
    
    has_many :assignments
    has_many :projects, through: :assignments

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone_number, presence: true, length: {10}
end
