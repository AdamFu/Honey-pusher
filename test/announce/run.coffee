# Test socket.io-announce

mix = require('mixture').mix()
configs = require './config'

api_port = configs.apiport
socket_port = configs.socketport
node_id = 0

api = mix.task 'api', filename: configs.api_runner
sio = mix.task 'socket.io', filename: configs.sio_runner

api.fork args: [api_port]
#for i in [1..configs.numCPUs]
while configs.numCPUs -= 1
    sio.fork args: [socket_port += 1, node_id += 1]

