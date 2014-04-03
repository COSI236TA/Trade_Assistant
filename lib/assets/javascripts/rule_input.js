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
    },
    onAdd: add_token,
    onDelete: delete_token
  }
);

function show_stock_info(token, stock_data) {
  output = ""; 
  current = stock_data.last_trade_price_only;
  time = stock_data.last_trade_time;
  date = stock_data.last_trade_date;
  day_low = stock_data.day_low;
  day_high = stock_data.day_high;
  year_low = stock_data.fifty_two_week_low;
  year_high = stock_data.fifty_two_week_high;
  p_e = stock_data.p_e_ratio;
  fifty_day_ma = stock_data.fifty_day_moving_average;

  output += "<div id = 'stock-" + token.ticker+ "' class = 'panel panel-success'>" +
            "  <div class = 'panel-heading'>" +
            "    <h6 class = 'panel-title'>" + token.name + "</h6>" +
            "  </div>" +
            "  <div class = 'panel-body' >" +
            "    <strong>" + current + "</strong> <small>" + time + " " + date + "</small><br />" + 
            "    <small>Day Range: " + day_low + "-" + day_high + "</small>&nbsp;&nbsp;&nbsp;&nbsp;" +
            "    <small>Year Range: " + year_low + "-" + year_high + "</small> <br />" +
            "    <small>50-day Moving Average: " + fifty_day_ma +"</small>&nbsp;&nbsp;&nbsp;&nbsp;" + 
            "    <small>P/E:" + p_e + "</small>" +
            "  </div>" +
            "</div>";
  return output;
}
var back;
function add_token(token) {
  $.get(
    "stock_info", 
    {
      ticker: token.ticker
    }, 
    function(data) {
      back = data;
      $("#portfolio_info").append(
        show_stock_info(token, data)
      );
    }
  );
}

function delete_token(token) {
  var id = "stock-" + token.ticker;
  $("#" + id).remove();
}

var back1;
var back2;
function selected_portfolio(pid) {
  $.get(
    "portfolio_info", 
    {
      pid: pid
    }, 
    function(stocks) {
      back1 = stocks;
      for (var i = 0; i < stocks.length; i++) {
        var stock = stocks[i];
        var token = {ticker: stock.ticker, name: stock.name };
        var stock_data = stock.stock_data;
        back1 = token;
        back2 = stock_data;
        $("#portfolio_info").append(
          show_stock_info(token, stock_data)
        );
      }
    }
  );
}

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
selected_portfolio(prevSelectedPortfolio.attr("pid"));

$(document).on("click", ".portfolio_item", function() {
  if (prevSelectedPortfolio !== null) {
    prevSelectedPortfolio.toggleClass("active");
  }
  $(this).toggleClass("active");
  prevSelectedPortfolio = $(this);
  $("#portfolio_info").empty();
  selected_portfolio($(this).attr("pid"));
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