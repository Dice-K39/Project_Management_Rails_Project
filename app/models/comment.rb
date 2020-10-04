class Comment < ApplicationRecord
    belongs_to :assignment
    belongs_to :programmer

    validates :title, presence: true
    validates :content, presence: true

    def full_name
        self.programmer.first_name + ' ' + self.programmer.last_name
    end
end
