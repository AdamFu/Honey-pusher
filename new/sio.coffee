redis = require "redis"
S = require 'string'
io = require('./setup/io')()
nodeId = process.argv[3] or 0

console.log 'running'

pubsub = redis.createClient()
pubsub.on 'message', (_channel, _msg)->
    if _msg is 'onlines'
        return console.log io.sockets.clients().length
     
    data = JSON.parse _msg
    console.log data.room, data.type
    io.sockets.in(data.room).emit data.type, data
       
io.sockets.on 'connection', (_s)->
    console.log "client connected: #{ _s.id } with nodeid: #{ nodeId }"
    _s.on 'client-session', (data)->

        ip = _s.handshake.address.address

        key = data.key ? ip
        key = "#{ data.project }:#{ key }"

        _s.join key
        _s.join data.project

        if data.channels then for channel in data.channels.split(',')
            channel = S(channel).trim().s
            _s.join "#{ data.project }:channel:#{ channel }"

        
    _s.on 'disconnect', (_user)->
        console.log 'disconnect'
        #pubsub = null

pubsub.subscribe "honey:pusher:#{ nodeId }"

###
c = ()-> console.log io.sockets.clients()
setInterval c, 2000
###
