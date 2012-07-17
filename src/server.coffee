# honey-pusher. server based socket.io

express = require 'express'
S = require 'string'
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
        if data.channels then for channel in data.channels.split(',')
            channel = S(channel).trim().s
            socket.join "#{ data.project }:channel:#{ channel }"
