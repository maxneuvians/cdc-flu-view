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

    data =
      'No Report': []
      'No Activity': []
      'Sporadic': []
      'Local Activity': []
      'Regional': []
      'Widespread': []

    $ = cheerio.load(content)
    i = 0
      
    last_timeperiod = $("flureport").children().last()
    title = last_timeperiod.attr("subtitle")
    last_timeperiod.children().each (i, elem) ->

      label = $(this).find("label").text()
      state = $(this).find("abbrev").text()

      data[label].push state
      return

    res.render('index', { title: title, data: data})
    return 
  return

app.set('view engine', 'jade');
app.set('port', (process.env.PORT || 3000));
app.use(express.static(__dirname + '/public'));

app.get '/', (req, res) ->
  loadData res
  return

server = app.listen(app.get('port'), ->
  console.log 'Listening on port %d', server.address().port
  return
)