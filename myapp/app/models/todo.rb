class Todo < ApplicationRecord
    before_validation :strip_and_upcase_name
    validates :todo_info, presence: true
    validates :todo_complete, presence: true
    validates :todo_info, length: { maximum: 255 }

    def strip_and_upcase_name
        self.todo_info.strip!
        self.todo_info.gsub!(/\A[[:space:]]*|[[:space:]]*\z/, '').gsub!(/\A[[\u3164]]*|[[\u3164]]*\z/, '')
    end
end 
