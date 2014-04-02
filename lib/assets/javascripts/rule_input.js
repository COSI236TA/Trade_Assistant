$(document).on("click", ".scroll-action", function() {
  var id = $(this).attr("id");
  var des = id.split("-")[1];
  scroll_to(des);
  return false;
});

$("#portfolio_tickers").tokenInput(
  "ticker_auto_complete", 
  {
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

$(document).on("click", ".property_item", function() {
  alert(parent);
  var parent = this.parent();
  var curr = parent.index(this);
  activate(parent, curr, active_property);
  active_property = curr;
});

$(document).on("click", ".portfolio_item", function() {
  var parent = $("#portfolio_list")
  alert(parent);
  var curr = parent.index(this);
  // alert($(this));
  activate(parent, curr, active_property);
  active_portfolio = curr;
});

function activate(parent, curr, prev) {
  var curr_item = parent.children()[curr];
  var prev_item = parent.children()[prev];
  // alert(parent);
  // alert(curr_item);
  // alert(prev_item);
  if (curr_item != null) {
    alert(1);
    curr_item.toggleClass("active");
  }
  if (prev_item != null) {
    alert(2);
    prev_item.toggleClass("active");
  }
}


function create_rule() {
  var portfolio = $("#portfolio"); 
  var property = $("#property");
  var rel = $("#rel");
  var target = $("#target");
}


function scroll_to(id) {
  var target = $("#".concat(id));
  $("html, body").animate({
    scrollTop: target.offset().top
  }, 500);
}