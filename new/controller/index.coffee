reqs = require '../tools/req'
r = require '../tools/redis'
querystring = require 'querystring'
url = require "url"
path = require "path"
fs = require "fs"

module.exports = (req, res)->

    if req.method is 'POST' and req.url.match /^\/pub$/
        # publish
        reqs.body req, (_body)->
            r.pub _body
            res.end '{"status": "ok"}'
    else
        uri = url.parse(req.url).pathname
        filename = path.join process.cwd(), "static/#{ uri }"
        fs.exists filename, (_exists)->
            if not _exists
                reqs.send res, 'Honey Pusher'
                return
            fs.readFile filename, "binary", (_err, _file)->
              if _err
                  res.writeHead 500, "Content-Type": "text/plain"
                  res.write err
                  res.end()
                  return

              res.writeHead 200
              res.write _file, "binary"
              res.end()

        

