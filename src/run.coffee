# using proxy socket.io and api server
# Lian Hsueh

httpProxy = require 'http-proxy'
http = require 'http'

s = new httpProxy.HttpProxy {
    target:
        host: 'localhost'
        port: 9999
}

proxyServer = http.createServer (req, res)->
    if req.url.match /socket.io/
        s.proxyRequest req, res
    else
        res.writeHead(200, {'Content-Type': 'text/plain'})
        res.end('okay')
proxyServer.on 'upgrade', (req, socket, head)->
    s.proxyWebSocketRequest(req, socket, head)

proxyServer.listen(9001)
