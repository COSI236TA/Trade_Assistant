


function get_rating(stock_ticker){
  
  //hides rating text and shows loader spinner
  document.getElementById("rating_text_" + stock_ticker).style.display = "none";
  document.getElementById("load_image_" + stock_ticker).style.display = "inline-block";

    
        $.ajax({
        type: 'GET',
        url: "/get_twitter_rating",
        data: {stock: stock_ticker},
        dataType: 'text',
          success: function(data){
              document.getElementById("load_image_" + stock_ticker).style.display = "none";
              document.getElementById("rating_text_" + stock_ticker).style.display = "inline-block";
              document.getElementById("rating_text_" + stock_ticker).innerHTML = data;


          }
      });


}

function create_stock_compare_chart(stocks_tickers){

var seriesOptions = [],
    yAxisOptions = [],
    seriesCounter = 0,
    names = stocks_tickers,
    colors = Highcharts.getOptions().colors;

       $.ajax({
        type: 'GET',
        url: "/get_stock_history",
        data: {tickers: stocks_tickers},
        dataType: 'json',
        success: function(data){

          document.getElementById("load_image_all").style.display = "none";

          index = 0
          for(var x=0;x < data.length;x++){

            //check if each stock has enough data returned
            if(data[x].length == 253){
             seriesOptions[index]={
              name: stocks_tickers[x],
              data: data[x]
             };
             index = index + 1
            }
   
         }

           createChart();
      
    }

  });

  // create the chart when all data is loaded
  function createChart() {

    $('#show_all').highcharts('StockChart', {

        chart: {
            height : 300,
            width : 800

        },
        rangeSelector: {
        inputEnabled: $('#show_all').width() > 480,
            selected: 4
        },

        yAxis: {
          labels: {
            formatter: function() {
              return (this.value > 0 ? '+' : '') + this.value + '%';
            }
          },
          plotLines: [{
            value: 0,
            width: 2,
            color: 'silver'
          }]
        },
        
        plotOptions: {
          series: {
            compare: 'percent'
          }
        },
        
        tooltip: {
          pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
          valueDecimals: 2
        },
        
        series: seriesOptions
    });

   
  }



}


//Creates the highstock graph given a ticker and its data. Data format is [[x,y], [x2,y2]...].
//It uses the ticker for the div id to change/add the graph.

function create_stock_chart(ticker, ticker_data){

          //check if the element with id ticker exists or not
          if ($("#" + ticker).length == 0) {
              alert("Element with id " + ticker + " does not exist...");
          }
          else{
                  
                  $("#" + ticker).highcharts('StockChart', {
                    
                    chart: {
                        height : 300,
                        width : 800

                    },
                    rangeSelector : {
                        selected : 1,
                        inputEnabled: $("#" + ticker).width() > 480
                    },

                    title : {
                        text : ticker + ' Stock Price'
                    },
                    
                    series : [{
                        name : 'Price',
                        data : ticker_data,
                        tooltip: {
                            valueDecimals: 2
                        }
                    }]
                });
          }

}

//Hides the charts based on the option value. 
//Used in the get_portfolio_html.html.erb
function option_on_change_chart(stock_tickers_array){

    //get option value
    var option = document.getElementById("options").value;
    //array of stock tickers

    //if an option, not all, is selected then show that certain graph
    if(option != "all"){
        for(var x=0;x < stock_tickers_array.length;x++){

            //hides all chart
            document.getElementById(stock_tickers_array[x]).style.display = "none";

        }

         document.getElementById("show_all").style.display = "none";
         //makes chart visible
         document.getElementById(option).style.display = "block";

    }

    else{

          for(var x=0;x < stock_tickers_array.length;x++){

            //hides all chart
            document.getElementById(stock_tickers_array[x]).style.display = "none";

        }
           //makes chart visible
           document.getElementById("show_all").style.display = "block";
        

    }


}



//creates a live chart, taking input as element's(div) id
function create_live_chart(container_id){

  Highcharts.setOptions({
    global : {
      useUTC : false
    }
  });
  
  // Create the chart
  $('#' + container_id).highcharts('StockChart', {
    chart : {
      events : {
        load : function() {

          // set up the updating of the chart each second
          var series = this.series[0];
          setInterval(function() {
            var x = (new Date()).getTime(), // current time
            y = Math.round(Math.random() * 100);
            series.addPoint([x, y], true, true);
          }, 1000);
        }
      },
      height : 300,
       width : 600,
    },
    
    rangeSelector: {
      buttons: [{
        count: 1,
        type: 'minute',
        text: '1M'
      }, {
        count: 5,
        type: 'minute',
        text: '5M'
      }, {
        type: 'all',
        text: 'All'
      }],
      inputEnabled: false,
      selected: 0
    },
    
    title : {
      text : 'Live random data'
    },
    
    exporting: {
      enabled: false
    },
    
    series : [{
      name : 'Random data',
      data : (function() {
        // generate an array of random data
        var data = [], time = (new Date()).getTime(), i;

        for( i = -999; i <= 0; i++) {
          data.push([
            time + i * 1000,
            Math.round(Math.random() * 100)
          ]);
        }
        return data;
      })()
    }]
  });



}