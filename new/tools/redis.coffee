
redis = require "redis"
querystring = require 'querystring'

r = redis.createClient()
r.on "error", (_e)->
    console.log "redis error: #{ _e }"

r.flushall()

module.exports =
    pub: (_data)->
        data = querystring.parse _data
        if data.project
            ###
            Get room name
            ###
            if data.type is 'subscribe'
                room = "#{data.project}:channel:#{data.channel}"
            else
                room = if data.to then "#{ data.project}:#{ data.to }" else data.project
            console.log room
            data.room = room
        #io.sockets.in(room).emit data.type, data
        console.log data
        r.publish "honey:pusher:1", JSON.stringify data
        #r.publish "honey:pusher:2", JSON.stringify data
        #r.publish "honey:pusher:3", JSON.stringify data
        #r.publish "honey:pusher:4", JSON.stringify data
        #r.publish "honey:pusher:5", JSON.stringify data
    onlines: -> r.publish "honey:pusher", 'onlines'
