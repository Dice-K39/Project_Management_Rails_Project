class Assignment < ApplicationRecord
    has_many :comments
    
    belongs_to :programmer
    belongs_to :project
end
