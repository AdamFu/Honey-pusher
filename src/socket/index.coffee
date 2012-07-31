"use strict"
# Lian Hsueh 7.20/2012
#
_ = require('underscore')._
S = require 'string'
auth = require "../tools/auth"
r = require('../tools/redis')()

pushOnlines = (_s)->
    #_s.broadcast.emit 'onlines', r.keys 'onlines'
    r.keys 'onlines:*', (_e, _onlines)->
        onlines = _.map _onlines, (_item)->
            return _item.replace "onlines:", ""
        #_s.broadcast.emit 'onlines', onlines
        _s.sockets.in('admin').emit 'onlines', onlines

module.exports = (io)->
    io.set 'log level', 1
    pushOnlines io
    io.sockets.on 'connection', (socket)->
        ip = socket.handshake.address.address
        console.log "#{ ip }.. viewing"

        socket.on 'client-admin', (data)->
            console.log auth.is_admin(data)
            if auth.is_admin data
                socket.join "admin"
            else
                socket.emit 'out', 1
            
        socket.on 'client-session', (data)->

            key = data.key ? ip
            key = "#{ data.project }:#{ key }"
            socket.key = key

            r.lpush "onlines:#{ key }", socket.id
            pushOnlines io

             
            socket.join key
            socket.join data.project
            if data.channels then for channel in data.channels.split(',')
                channel = S(channel).trim().s
                socket.join "#{ data.project }:channel:#{ channel }"

        socket.on 'disconnect', (_user)->
            key = "onlines:#{ socket.key }"
            r.lrem key, 0, socket.id
            
            r.llen key, (_e, _rs)->
                if not _rs
                    r.del key
                pushOnlines io
