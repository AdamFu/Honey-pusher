express = require 'express'
configs = require './config'
app = express.createServer()

app.listen 9999

app.get '/', (req, res)->
    res.send 'Honey Pusher by honey lab'

