# honey-pusher. server based socket.io

express = require 'express'
configs = require './config'
app = express.createServer()
app.listen '0.0.0.0', configs.port

io = require('socket.io').listen(app)

require('./setup')(app, express, io)
require('./controller')(app, io)

io.sockets.on 'connection', (socket)->
    socket.on 'client-session', (data)->
        socket.join "#{ data.project }:#{ data.key }"
        socket.join data.project
