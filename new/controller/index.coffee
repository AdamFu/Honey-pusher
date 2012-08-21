reqs = require '../tools/req'
announce = require '../tools/announce'
pass = require '../tools/pass'
url = require "url"

module.exports = (req, res)->
    if req.method is 'POST' and req.url.match /^\/pub$/
        # publish
        reqs.body req, (_body)->

            if pass _body
                announce.pub _body
                reqs.send res,'{"status": "ok"}'
            else
                reqs.send res,'{"status": "error"}'

    else
        uri = url.parse(req.url).pathname
        switch true
            when !!uri.match /\.js$/ then reqs.static res, uri
            when uri is '/onlines'
                announce.onlines()
                reqs.send res, 'onlines'
            else reqs.send res, 'Honey-Pusher by honey lab'



