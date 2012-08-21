redis = require "redis"
S = require 'string'
io = require('./setup/io')()

nodeId = process.argv[3] or 0
console.log 'running'
      
io.sockets.on 'connection', (_s)->
    console.log "client connected: #{ _s.id } with nodeid: #{ nodeId }"
    closed = off
    _s.on 'client-session', (data)->
        if closed then return console.log '--- closed session ---'
        ip = _s.handshake.address.address

        key = data.key ? ip
        key = "#{ data.project }:#{ key }"
        
        _s.join key
        _s.join data.project

        if data.channels then for channel in data.channels.split(',')
            channel = S(channel).trim().s
            _s.join "#{ data.project }:channel:#{ channel }"

    _s.on 'disconnect', (_user)->
        closed = on
        console.log "disconnect: #{ _s.id }"
        _sockets = io.sockets
        delete _sockets.sockets[_s.id]
        #delete _sockets.manager.handshaken[_s.id]
        #delete _sockets.manager.closed[_s.id]
        #delete _sockets.manager.connected[_s.id]
        #delete _sockets.manager.open[_s.id]
        #delete _sockets.manager.roomClients[_s.id]
        _s.removeAllListeners 'client-session'
        _s = null
