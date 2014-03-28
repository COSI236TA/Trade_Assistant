$(document).ready(function() {
  $("#rule_ticker").tokenInput(
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
  $(".scroll-action").click(function() {
      var id = $(this).attr("id");
      var des = id.split("-")[1];
      var target = $("#".concat(des));
      $("html, body").animate({
        scrollTop: target.offset().top
      }, 500);
      return false;
    }
  );
});