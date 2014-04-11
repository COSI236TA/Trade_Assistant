//Creates the highstock graph given a ticker and its data. Data format is [[x,y], [x2,y2]...].
//It uses the ticker for the div id to change/add the graph.

function create_stock_chart(ticker, ticker_data){

					if ($("#" + ticker).length == 0) {
  						alert("Element " + ticker + " does not exist...");
					}

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