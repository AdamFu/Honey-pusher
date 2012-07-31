# using node-cluster
# Lian Hsueh

cluster = require 'node-cluster'
configs = require './config'
#store = new (require('socket.io-clusterhub'))
master = cluster.Master({})
master.register('pusher', "#{__dirname}/server.js", listen: configs.port).dispatch()
