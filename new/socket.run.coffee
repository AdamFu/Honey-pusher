# socket.io server
# Lian Hsueh

redis = require "redis"
configs = require './config'
io = require('socket.io').listen configs.socketport
S = require 'string'
r = redis.createClient()

r.set 'onlines', 1
io.set 'log level', 1

console.log 'running'

pubsub = redis.createClient()

pubsub.on 'message', (_channel, _msg)->
    data = JSON.parse _msg
    io.sockets.in(data.room).emit data.type, data
       

io.sockets.on 'connection', (_s)->
    _s.on 'client-session', (data)->

        ip = _s.handshake.address.address
        console.log ip
        r.incr 'onlines'

        key = data.key ? ip
        key = "#{ data.project }:#{ key }"

        _s.join key
        _s.join data.project

        if data.channels then for channel in data.channels.split(',')
            channel = S(channel).trim().s
            _s.join "#{ data.project }:channel:#{ channel }"

        
    _s.on 'disconnect', (_user)->
        r.decr 'onlines'
        #pubsub = null

pubsub.subscribe "honey:pusher"
