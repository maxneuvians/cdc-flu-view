function drawMap(title, data, isLast, isFirst)
{
  series_data = []

  colors = {
    "No Report": "#d4e8fa",
    "No Activity": "#fff",
    "Sporadic": "#9cc4e9",
    "Local Activity": "#7faeda",
    "Regional": "#6597c6",
    "Widespread": "#5283b0"
  }

  $.each(data, function (key, states) {

      series = {
        data: $.map(data[key], function (code) {
            return { code: code };
        }),
        dataLabels: {
            enabled: true,
            color: '#000',
            format: '{point.code}'
        },
        name: key,
        color: colors[key]
      }
      series_data.push(series)
  });

  $('#cdc_flu_view').highcharts('Map', {

      chart : {
          borderWidth : 0,
      },

      title : {
          text: 
            "<a id='prevLink' href='#' style='text-decoration:none;'>&larr;</a> " + 
            title + 
            " <a id='nextLink' href='#' style='text-decoration:none;'>&rarr;</a>",
          useHTML: true,
          events: {
            click: function (event) {
              alert("hi there");
            }
          }

      },

      subtitle : {
          text: 'Source: <a href="http://www.cdc.gov/flu/weekly/flureport.xml" target="_blank">http://www.cdc.gov/flu/weekly/flureport.xml</a>',
          useHTML: true,
          verticalAlign: 'bottom',
          align: 'center',
          floating: true,
          x: 0,
          y: 13

      },

      legend: {
          layout: 'horizontal',
          borderWidth: 0            
      },

      mapNavigation: {
          enabled: true
      },

      plotOptions: {
        map: {
            allAreas: false,
            joinBy: ['postal-code', 'code'],
            mapData: Highcharts.maps['countries/us/us-all'],
            tooltip: {
                headerFormat: '',
                pointFormat: '{point.name}: <b>{series.name}</b>'
            },
            borderColor: '#a7a7a7'

          }
      },
      series : series_data
  });

  $('#prevLink').click(function () {
    show_prev();
    return false;
   });
  $('#nextLink').click(function () {
    show_next();
    return false;
   });
}

function show_next()
{
  current_index = current_index + 1
  if(current_index >= collection.length)
  {
    current_index = collection.length - 1
  }
  drawMap(collection[current_index].title, collection[current_index].data);
}

function show_prev()
{ 
  current_index = current_index - 1
  if(current_index < 0)
  {
    current_index = 0
  }
  drawMap(collection[current_index].title, collection[current_index].data);

}