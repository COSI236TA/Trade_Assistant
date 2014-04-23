class Stock < ActiveRecord::Base
    has_and_belongs_to_many :portfolios
    validates :ticker, presence: true, uniqueness: true
    validate :valid_ticker?

    def valid_ticker?
      if STOCK_LIST[ticker] == nil
        errors.add(:ticker, "Invalid ticker")
      end
    end

    def name
      STOCK_LIST[ticker]
    end
end
