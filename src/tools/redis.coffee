#init redis

redis = require "redis"
module.exports = ()->
    r = redis.createClient()
    r.on "error", (_e)->
        console.log "redis error: #{ _e }"

    r.flushall()

    return r


