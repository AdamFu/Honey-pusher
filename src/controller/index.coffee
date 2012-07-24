configs = require '../config'
module.exports = (app, io)->

    app.get '/', (req, res)->
        res.render 'index', layout: false, pusher: configs.domain

    app.get '/2', (req, res)->
        res.render 'index2', layout: false, pusher: configs.domain

    app.get '/3', (req, res)->
        res.render 'index3', layout: false, pusher: configs.domain
    [ 'publish', 'subscribe' ].map (controllerName)->
        require('./' + controllerName)(app, io)
