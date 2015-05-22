helper = require './spec-helper'

describe "App", ->  

  describe "get /", ->

    it "responds successfully", ->

      helper.withServer (r, done) ->

        r.get "/", (err, res, body) ->
          expect(res.statusCode).toEqual 200
          done()

    it "Sets the correct title object", ->

      helper.withServer (r, done) ->
        
        r.get "/", (err, res, body) ->
          expect(body.indexOf("<title>CDC Flu View for Week Ending May 09, 2015- Week 18</title>")).not.toEqual -1
          done()

    it "creates a JSON representation of the XML data", ->

      helper.withServer (r, done) ->
        
        r.get "/", (err, res, body) ->
          expect(body.indexOf('{"No Report":[],"No Activity":["VI","NC","TN","MS","AR","KS","ID"],"Sporadic":["RI","PA","DE","MD","DC","VA","WV","GA","FL","KY","AL","IN","WI","MN","LA","TX","IA","MO","NE","ND","SD","WY","CO","UT","NV","CA","WA","AK"],"Local Activity":["VT","NJ","PR","SC","OH","IL","MI","OK","NM","MT","AZ","HI","OR"],"Regional":["ME","NH","GU"],"Widespread":["MA","CT","NY"]}
')).not.toEqual -1
          done()