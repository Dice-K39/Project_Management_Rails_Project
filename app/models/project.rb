class Project < ApplicationRecord
    has_many :assignments
    has_many :programmers, through: :assignments
    
    has_many :comments
end
