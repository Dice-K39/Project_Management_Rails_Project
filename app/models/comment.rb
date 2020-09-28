class Comment < ApplicationRecord
    belongs_to :assignment

    validates :title, presence: true
    validates :content, presence: true
end
