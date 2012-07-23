"use strict"
# Lian Hsueh 7.20/2012

onlines = ''
module.exports = (io)->
    io.set 'log level', 1
    io.sockets.on 'connection', (socket)->
        socket.on 'client-session', (data)->
            
            key = "#{ data.project }:#{ data.key }"
            
            console.log socket.id, onlines
            onlines += "[#{ key }:#{ socket.id }]"
            socket.broadcast.emit 'add_user', socket.id
             
            socket.join key
            socket.join data.project
            if data.channels then for channel in data.channels.split(',')
                channel = S(channel).trim().s
                socket.join "#{ data.project }:channel:#{ channel }"

        socket.on 'disconnect', (_user)->
            console.log '----disconnect---'
            console.log socket.id
            console.log '----disconnect end---'
