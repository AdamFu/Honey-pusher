# https://github.com/dshaw/socket.io-announce
#
querystring = require 'querystring'
announce = require('socket.io-announce').createClient()

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
        announce.in(room).emit data.type, data

    onlines: -> console.log 'onlines'
