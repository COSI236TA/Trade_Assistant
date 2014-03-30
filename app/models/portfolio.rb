class Portfolio < ActiveRecord::Base
    has_many :stock
    has_many :rule
    belongs_to :user
end
