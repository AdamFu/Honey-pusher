reqs = require '../tools/req'
r = require '../tools/redis'
url = require "url"

module.exports = (req, res)->
    if req.method is 'POST' and req.url.match /^\/pub$/
        # publish
        reqs.body req, (_body)->
            r.pub _body
            res.end '{"status": "ok"}'
    else
        uri = url.parse(req.url).pathname
        switch true
            when !!uri.match /\.js$/ then reqs.static res, uri
            when uri is '/onlines'
                r.onlines()
                reqs.send res, 'onlines'
            else reqs.send res, 'honey pusher / honey lab'
