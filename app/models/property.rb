class Property < ActiveRecord::Base
    validates :p_id, presence: true
    validates :p_id, uniqueness: true
    def to_s
        d_name
    end
end
