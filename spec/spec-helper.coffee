require './fakeweb-helper'
request = require "request"

class Requester  
  get: (path, callback) ->
    request "http://localhost:4000#{path}", callback

  post: (path, body, callback) ->
    request.post {url: "http://localhost:4000#{path}", body: body}, callback

exports.withServer = (callback) ->  
  asyncSpecWait()

  {app} = require "../lib/cdc-flu-view.coffee"

  stopServer = ->
    server.close()
    asyncSpecDone()

  server = app.listen 4000

  callback new Requester, stopServer