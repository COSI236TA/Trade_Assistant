// $(document).on("change:page", function() {
//   $("#rule_portfolio_stocks_ticker").tokenInput(
//     "ticker_auto_complete", {
//       theme: "facebook",
//       propertyToSearch: "ticker",
//       hintText: "Type in company name or ticker",
//       tokenValue: "ticker",
//       preventDuplicates: "true",
//       minChars: 2,
//       resultsFormatter: function(item) {
//         return "<li>" + item.name + "(" + item.ticker + ")" + "</li>";
//       },
//       tokenFormatter: function(item) {
//         return "<li>" + item.ticker + "</li>";
//       }
//     }
//   );
// });


$(document).on("click", ".scroll-action", function() {
  var id = $(this).attr("id");
  var des = id.split("-")[1];
  scroll_to(des);
  return false;
});

$("#rule_portfolio_stocks_ticker").tokenInput(
  "ticker_auto_complete", {
    theme: "facebook",
    propertyToSearch: "ticker",
    hintText: "Type in company name or ticker",
    tokenValue: "ticker",
    preventDuplicates: "true",
    minChars: 2,
    resultsFormatter: function(item) {
      return "<li>" + item.name + "(" + item.ticker + ")" + "</li>";
    },
    tokenFormatter: function(item) {
      return "<li>" + item.ticker + "</li>";
    }
  }
);

function scroll_to(id) {
  var target = $("#".concat(id));
  $("html, body").animate({
    scrollTop: target.offset().top
  }, 500);
}