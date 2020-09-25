class Assignment < ApplicationRecord
    has_many :comments
    
    belongs_to :programmer, optional: true
    belongs_to :project, optional: true
end
