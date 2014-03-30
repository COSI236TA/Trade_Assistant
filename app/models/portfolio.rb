class Portfolio < ActiveRecord::Base
    has_many :rule
    has_and_belongs_to_many :stock
    belongs_to :user
end
