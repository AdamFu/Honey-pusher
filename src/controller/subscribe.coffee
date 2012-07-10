subscribe = (req, res)->
    res.send 'subscribe'

module.exports = (app)->
    app.get '/sub', subscribe

