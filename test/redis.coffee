redis = require "redis"
_ = require('underscore')._

r = redis.createClient()
r.select 'pusher2', ()->
    r.on "error", (_e)->
        console.log "redis error: #{ _e }"

    r.lpush 'ihunantv:123:s1', 'u'
    r.lpush 'ihunantv:123:s1', 'u'
    r.lpush 'ihunantv:222:s2', 'u'
    r.lpush 'ihunantv:222:s3', 'u'
    #
    #r.lrem 'ihunantv:123:s1', 1, 'u1', (_e, _rs)->
    #    console.log _rs

    r.lrange 'ihunantv:123:s1', 0, -1, (_e, _rs)->
        console.log _rs
    #r.flushall()
    #r.keys 'ihunantv:*', (_e, _rs)->
    #    r.mget _rs, (_e, _rs)->
    #        console.log _rs

