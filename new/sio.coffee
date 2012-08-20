redis = require "redis"
S = require 'string'
io = require('./setup/io')()

nodeId = process.argv[3] or 0
console.log 'running'

pubsub = redis.createClient()
pubsub.on 'message', (_channel, _msg)->
    console.log "=="
    console.log _channel, _msg
    console.log "=="
#    if _msg is 'onlines'
#        _m = io.sockets.manager
#
#        o = Object.keys(_m.open).length
#        c = Object.keys(_m.closed).length
#        h = Object.keys(_m.handshaken).length
#        cnt = Object.keys(_m.connected).length
#        r = Object.keys(_m.roomClients).length
#
#        console.log "open: #{o}"
#        console.log "closed: #{c}"
#        console.log "handshaken: #{h}"
#        console.log "connected: #{cnt}"
#        console.log "roomClients: #{r}"
#        
#        return console.log "---"
#
#return console.log io.sockets.clients().length
#     
#    data = JSON.parse _msg
#    console.log data.room, data.type
#    io.sockets.in(data.room).emit data.type, data
       
io.sockets.on 'connection', (_s)->
    console.log "client connected: #{ _s.id } with nodeid: #{ nodeId }"
    closed = off
    _s.on 'client-session', (data)->
        if closed then return console.log '--- closed session ---'
        ip = _s.handshake.address.address

        key = data.key ? ip
        key = "#{ data.project }:#{ key }"
        
        _s.join 'abc'
        _s.join key
        _s.join data.project
        console.log key
        console.log data.project

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
        #pubsub = null

#console.log "sub:honey:pusher:#{ nodeId }"
#pubsub.subscribe "honey:pusher:#{ nodeId }"


#c = ()->
#    m = io.sockets.manager
#    t1 = new Date().getTime()
#    console.log "== clear start ==="
#    for _id, _hs in m.closed
#        if not m.open[_id] then delete m.closed[_id]
#    t2 = new Date().getTime()
#    console.log "== clear end #{ t2 - t1 } ==="

    #console.log "====="
    #console.log "====="
    #console.log "====="
    #console.log io.sockets
    #console.log "====="
    #console.log "====="
    #console.log "== destroy ==="
    #io.sockets.manager.handshaken = null
    #io.sockets.manager.handshaken = null

c = ()->
    console.log '-------------------'
    console.log io.sockets.manager.rooms
    #io.sockets.in('abcd').emit 'msg', 'from socket.io'
setTimeout c, 5000
