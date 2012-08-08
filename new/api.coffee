http = require 'http'
http_server = http.createServer require('./controller')
port = process.argv[2] or 8880
http_server.listen ~~port

