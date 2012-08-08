# socket.io server
# Lian Hsueh

io = require('socket.io').listen(8888)
io.sockets.on 'connection', (_s)->
    console.log 'socket.io ok'
    _s.emit 'news', 'hey'
    
