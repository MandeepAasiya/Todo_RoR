class Task < ApplicationRecord

    enum priorities: [:Normal, :Medium, :High]
    validates_presence_of :title
    validates_length_of :title, :maximum => 40
    validates_length_of :description, :maximum => 1024

end
