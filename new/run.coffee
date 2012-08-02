# using proxy socket.io and api server
# Lian Hsueh

httpProxy = require 'http-proxy'
http = require 'http'
configs = require './config'

s = new httpProxy.HttpProxy {
    target:
        host: 'localhost'
        port: configs.socketport
}

proxyServer = http.createServer (req, res)->
    if req.url.match /socket.io/
        s.proxyRequest req, res
    else
        require('./controller')(req, res)

proxyServer.on 'upgrade', (req, socket, head)->
    s.proxyWebSocketRequest(req, socket, head)

proxyServer.listen(configs.port)
