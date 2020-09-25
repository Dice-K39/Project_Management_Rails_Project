class Programmer < ApplicationRecord
    has_secure_password
    
    has_many :assignments
    has_many :projects, through: :assignments

    validates :username, :email, presence: true, uniqueness: true
    validates :password, :first_name, :last_name, presence: true
    validates :phone_number, presence: true, length: {is: 10}
end
