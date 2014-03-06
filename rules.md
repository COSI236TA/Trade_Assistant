#### Rule template

* Given
	* security-type: :nasdaq, :currency, :dj
	* security (of security-type): String
	* property: :price, :volume, :market_cap
	* relationship rel: :greater, :less
	* value-period: :current, :1day, :1month, :1year
	* period-statistic: :current, :maximum, :minimum, :average, :median

>	val = current_value(security-type, security, property)
hist = historical_value(security-type, security, value-period, period-statistic)
fire = compare(relationship, val, his)

>	security_to_s(security-type, security) -> "Google Corporation" or "US Dollar"
relationship_to_s(relationship) -> "greater than" | "less than"
value_period_statistic_to_s(value-period, period-statistic) -> "at present" | "maximum over the last 12 months" | "median over the last 24 hours"

>	"Notify me whenever the #{property} of #{security_to_s} is #{relationship} the value #{value_period_statistic)"