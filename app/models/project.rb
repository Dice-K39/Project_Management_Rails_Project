class Project < ApplicationRecord
    has_many :assignments
    has_many :programmers, through: :assignments
end
