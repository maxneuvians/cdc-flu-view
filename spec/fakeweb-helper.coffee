fakeweb = require('node-fakeweb');
fs = require('fs')

fakeweb.allowNetConnect = false

fakeweb.registerUri
  uri: 'http://www.cdc.gov:80/flu/weekly/flureport.xml'
  body: fs.readFileSync('./spec/support/flureport.xml').toString()