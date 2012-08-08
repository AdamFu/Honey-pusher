# using proxy socket.io and api server
# Lian Hsueh

mix = require('mixture').mix('epic')
bouncy = require 'bouncy'
configs = require './config'

api_port = configs.apiport
socket_port = configs.socketport
node_id = 0
ports = []

sio = mix.task 'socket.io', filename: configs.sio_runner
api = mix.task 'api', filename: configs.api_runner

for i in [0..configs.numCPUs]
    socket_port = socket_port + 1
    node_id = node_id + 1
    ports.push socket_port

    sio.fork args: [socket_port, node_id]

api.fork args: [api_port]

b = bouncy (req, bounce)->
    if req.url.match /^\/socket.io/
        bounce ports[Math.random()*ports.length|0]
    else
        bounce api_port

b.listen configs.port
