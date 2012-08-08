# setup io server

#configs = require '../config'
redis = require "redis"
sio = require 'socket.io'
RedisStore = sio.RedisStore
socket_port = process.argv[2] or 8880
nodeId = process.argv[3] or 0
io = sio.listen ~~socket_port


io.set 'log level', 1
io.enable 'browser client etag'
io.set 'transports', [
    'websocket',
    'flashsocket',
    'htmlfile',
    'xhr-polling',
    'jsonp-polling' ]

#io.set 'store', new RedisStore host: 'http://127.0.0.1'
pub = redis.createClient()
sub = redis.createClient()
client = redis.createClient()

io.set 'store', new RedisStore {
    redisPub: pub,
    redisSub: sub,
    redisClient : client
    nodeId: ()-> return nodeId
}

#io.set 'store', new RedisStore {
#    nodeId: ()-> return nodeId
#    #redisPub: redispub
#    #redisSub: redisSub
#    #redisClient: redisClient
#}

module.exports = -> io
