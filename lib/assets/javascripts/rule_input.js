$(document).ready(function() {
  $("#rule_ticker").tokenInput(
    "ticker_auto_complete", 
    {
      theme: "facebook",
      propertyToSearch: "ticker",
      resultsFormatter: function(item){ return "<li>" + item.name + "(" + item.ticker + ")" + "</li>" },
      tokenFormatter: function(item) { return "<li>" + item.ticker + "</li>" }
    }
  );
});
