path = require "path"
fs = require "fs"

exports.send = send = (res, _msg)->
    res.writeHead 200, 'Content-Type': 'text/plain'
    res.end _msg

exports.body = (req, next)->
    buffer = []
    req.on 'data', (_chunk)->
        buffer.push(_chunk)

    req.on 'end', ()->
        next buffer.join('')
  
exports.static = (res, _uri)->
    filename = path.join process.cwd(), "static/#{_uri}"
    fs.exists filename, (_exists)->
        if not _exists
            send res, 'Honey Pusher'
            return
        fs.readFile filename, "binary", (_err, _file)->
          if _err
              send res, 'Honey Pusher > honey lab'
              return
          res.writeHead 200
          res.write _file, "binary"
          res.end()
