"use strict"
# Lian Hsueh 7.20/2012
#
_ = require('underscore')._
S = require 'string'

onlines =
    users: {}
    sessions: {}

pushOnlines = (_s)->
    _s.broadcast.emit 'onlines', _.keys onlines.users

module.exports = (io)->
    io.set 'log level', 1
    io.sockets.on 'connection', (socket)->
        users = onlines.users
        sessions = onlines.sessions
        console.log socket.handshake.address
        ip = socket.handshake.address.address
        pushOnlines socket

        socket.on 'client-session', (data)->
            key = "#{ data.project }:#{ data.key }:#{ ip }"

            sessions[socket.id] = key
            user = users[key]
            if user
                user.push socket.id
                user = _.uniq(user)
            else
                users[key] = [socket.id]
                socket.broadcast.emit 'add_user', key
                pushOnlines socket
             
            socket.join key
            socket.join data.project
            if data.channels then for channel in data.channels.split(',')
                channel = S(channel).trim().s
                socket.join "#{ data.project }:channel:#{ channel }"

        socket.on 'disconnect', (_user)->
            key = sessions[socket.id]
            user = users[key]
            delete sessions[socket.id]
            if user then users[key] = _.without(user, socket.id)
            user = users[key]
            if not user or not user.length
                delete users[key]
                socket.broadcast.emit 'remove_user', key
                pushOnlines socket
