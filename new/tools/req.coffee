
exports.send = (res, _msg)->
    res.writeHead 200, 'Content-Type': 'text/plain'
    res.end _msg

exports.body = (req, next)->
    buffer = []
    req.on 'data', (_chunk)->
        buffer.push(_chunk)

    req.on 'end', ()->
        next buffer.join('')
  
