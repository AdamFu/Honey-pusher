reqs = require '../tools/req'
#r = require '../tools/redis'
announce = require '../tools/announce'
url = require "url"

module.exports = (req, res)->
    if req.method is 'POST' and req.url.match /^\/pub$/
        # publish
        reqs.body req, (_body)->
            announce.pub _body
            res.end '{"status": "ok"}'
    else
        uri = url.parse(req.url).pathname
        switch true
            when !!uri.match /\.js$/ then reqs.static res, uri
            when uri is '/onlines'
                announce.onlines()
                reqs.send res, 'onlines'
            else reqs.send res, 'Honey-Pusher by honey lab'



