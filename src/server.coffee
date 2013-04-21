cradle = require 'cradle'
express = require 'express'

db = new(cradle.Connection)(process.env.COUCH_IP, process.env.COUCH_PORT, {auth: {username: process.env.COUCH_USERNAME, password: process.env.COUCH_PASSWORD}}).database('ouisharefest-mentions')

app = express()
app.use(express.static 'public')

app.get '/mentions/:screen_name', (req, res) ->

  screen_name = req.params.screen_name
  db.view 'peer/byScreenName', { key: screen_name.toLowerCase() }, (err, doc) ->
    if err
      console.log err
    else
      res.send doc

app.listen 7234
