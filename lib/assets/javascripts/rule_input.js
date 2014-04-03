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



//Form selections 

//Property
//select the first item by default
var prevSelectedProperty = $(".property_item").first();
prevSelectedProperty.toggleClass("active");

$(document).on("click", ".property_item", function() {
  if (prevSelectedProperty !== null) {
    prevSelectedProperty.toggleClass("active");
  }
  $(this).toggleClass("active");
  prevSelectedProperty = $(this);
});

//Portfolio
//selected item by default
var prevSelectedPortfolio = $(".portfolio_item").first();
prevSelectedPortfolio.toggleClass("active");

$(document).on("click", ".portfolio_item", function() {
  if (prevSelectedPortfolio !== null) {
    prevSelectedPortfolio.toggleClass("active");
  }
  $(this).toggleClass("active");
  prevSelectedPortfolio = $(this);
});

//Rel
//Selet the first one by default
var prevSelectedRel = $(".rel_item").first();
prevSelectedRel.toggleClass("active");

$(document).on("click", ".rel_item", function() {
  if (prevSelectedRel !== null) {
    prevSelectedRel.toggleClass("active"); 
  }
  $(this).toggleClass("active");
  prevSelectedRel = $(this);
});



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