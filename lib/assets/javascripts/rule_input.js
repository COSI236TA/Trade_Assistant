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


//Submit the rule
$("#submit").on("click", function() {

  var portfolio = $("#portfolio").first();
  var portfolio_data;
  if (portfolio.attr("name") == "create_portfolio") {
    var tickers = $("#portfolio_tickers").tokenInput("get");
    portfolio_data = { 
      action: "create", 
      name: $("#portfolio_name").val(),
      description: $("#portfolio_description").val(),
      ticker: tickers 
    };
  } else {
    portfolio_data = { action: "select", id: prevSelectedPortfolio.attr("pid") };
  }

  var rule_data = { 
    property: prevSelectedProperty.attr("pid"),
    rel: prevSelectedRel.attr("value"),
    target: $("#target_input").val()
  };

  var post_data = { portfolio: portfolio_data, rule: rule_data };
  $.post("create_rule", post_data, function(data) {
    if (data.response) {
      window.location = "dashboard";
    } else {
      alert("Create rule fail!");
    }
  });
});


function submit_rule() {
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