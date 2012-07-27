configs = require '../config'
module.exports = (app, io)->

    app.get '/', (req, res)->
        res.render 'online', layout: false, pusher: configs.domain

    app.get '/1', (req, res)->
        res.render 'index', layout: false, pusher: configs.domain, id: 1

    app.get '/2', (req, res)->
        res.render 'index', layout: false, pusher: configs.domain, id: 2

    app.get '/3', (req, res)->
        res.render 'index', layout: false, pusher: configs.domain, id: 3

    [ 'publish', 'subscribe' ].map (controllerName)->
        require('./' + controllerName)(app, io)
