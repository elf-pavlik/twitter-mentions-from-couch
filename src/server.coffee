Twit = require 'twit'
cradle = require 'cradle'
express = require 'express'

app = express()

db = new(cradle.Connection)(process.env.COUCH_IP, process.env.COUCH_PORT, {auth: {username: process.env.COUCH_USERNAME, password: process.env.COUCH_PASSWORD}}).database('ouisharefest-mentions')

T = new Twit
  consumer_key: process.env.CONSUMER_KEY
  consumer_secret: process.env.CONSUMER_SECRET
  access_token: process.env.ACCESS_TOKEN
  access_token_secret: process.env.ACCESS_TOKEN_SECRET


db.view 'peer/byScreenName', { key: 'elfpavlik' }, (err, doc) ->
  if err
    console.log err
  else
    #console.log doc

app.use(express.static 'public')

app.get '/mentions/:screen_name', (req, res) ->

  screen_name = req.params.screen_name
  db.view 'peer/byScreenName', { key: screen_name.toLowerCase() }, (err, doc) ->
    if err
      console.log err
    else
      res.send doc

app.listen 7234
