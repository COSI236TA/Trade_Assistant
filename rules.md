#### Rule template

* Given
	* security-type: :nasdaq, :currency, :nyse
	* security (of security-type): String
	* property: :price, :volume, :market_cap, :pe
	* taget: Number
	* target: :percent, :absolute
	* relationship rel: :greater, :less
	* value-period: :current, :1day, :1month, :1year
	* period-statistic: :current, :maximum, :minimum, :average, :median

```
val = current_value(security-type, security, property)
hist = historical_value(security-type, security, property, value-period, period-statistic)
fire = compare(relationship, val, hist)

security_to_s(security-type, security) -> "Google Corporation" or "US Dollar"
relationship_to_s(relationship) -> "greater than" | "less than"
value_period_statistic_to_s(value-period, period-statistic) -> "at present" | "maximum over the last 12 months" | "median over the last 24 hours"

Rule#to_s -> "Notify me whenever the #{property} of #{security_to_s} is #{relationship} the value #{value_period_statistic)"

property can be: "price", "price change", etc
security can be: Google, US$, etc
relationship can be: more than, less than, 10% more than
value_period_statistic can be: number, percent

"Notify me whenever the #{property} of #{"security_to_s} 
```