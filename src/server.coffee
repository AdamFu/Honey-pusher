# honey-pusher. server based socket.io

express = require 'express'
configs = require './config'
app = express.createServer()
app.listen configs.port

io = require('socket.io').listen(app)

require('./setup')(app, express, io)
require('./controller')(app, io)

io.sockets.on 'connection', (socket)->
    socket.on 'client-session', (data)->
        socket.join "#{ data.project }:#{ data.key }"
        socket.join data.project
        console.log data.channels
        for channel in data.channels
            socket.join "#{ data.project }:channel:#{ channel }"
