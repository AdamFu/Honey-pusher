http = require 'http'
url = require "url"
path = require "path"
fs = require "fs"

http_server = http.createServer (req, res)->
    
    filename = path.join process.cwd(), "index.html"
    
    fs.readFile filename, "binary", (_err, _file)->
        if _err
            res.writeHead 200, 'Content-Type': 'text/plain'
            res.end 'error'
        res.writeHead 200
        res.write _file, "binary"
        res.end()
        
port = process.argv[2] or 8880
http_server.listen ~~port

announce = require('socket.io-announce').createClient()
a = ()->
    announce.in('xxx').emit 'msg', 'Hi...Hi...Hi...only room xxx'
    announce.emit 'msg', 'Hi...Hi...Hi...all clients will get this msg'
setInterval a, 5000
