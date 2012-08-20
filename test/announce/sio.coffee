redis = require "redis"
sio = require 'socket.io'
RedisStore = sio.RedisStore

socket_port = process.argv[2] or 8880
nodeId = process.argv[3] or 0
io = sio.listen ~~socket_port


#io.set 'log level', 1
io.enable 'browser client etag'
io.set 'transports', [
    'websocket',
    #'flashsocket',
    #'htmlfile',
    'xhr-polling',
    'jsonp-polling' ]

pub = redis.createClient()
sub = redis.createClient()
client = redis.createClient()

io.set 'store', new RedisStore {
    redisPub: pub
    redisSub: sub
    redisClient : client
    nodeId: ()-> return nodeId
}

io.sockets.on 'connection', (_s)->
    console.log "client connected: #{ _s.id } with nodeid: #{ nodeId } room: xxx"
    _s.join 'xxx'
    _s.on 'disconnect', (_user)->
        console.log "disconnect: #{ _s.id }"
