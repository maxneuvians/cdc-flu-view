express = require('express')
cheerio = require('cheerio')
request = require('request')
exports.app = app = express()

loadData = (res) ->

  content = ''
  url = 'http://www.cdc.gov/flu/weekly/flureport.xml'
  request(decodeURIComponent(url)).on('data', (chunk) ->
    content = content + chunk
    return
  ).on 'end', ->

    collection = []

    $ = cheerio.load(content)
      
    $("flureport").children().each (i, elem) ->
      week_number = $(this).attr('year') + "-" + $(this).attr('number')

      data = 
        'title': $(this).attr("subtitle")
        'data':
          'No Report': []
          'No Activity': []
          'Sporadic': []
          'Local Activity': []
          'Regional': []
          'Widespread': []


      $(this).children().each (i, elem) ->

        label = $(this).find("label").text()
        state = $(this).find("abbrev").text()

        data['data'][label].push state

      collection.push data
      
    res.render('index', { collection: collection})
    return 
  return

app.set('view engine', 'jade');
app.set('port', (process.env.PORT || 3000));
app.use(express.static('public'));

app.get '/', (req, res) ->
  loadData res
  return

server = app.listen(app.get('port'), ->
  console.log 'Listening on port %d', server.address().port
  return
)