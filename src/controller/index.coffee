configs = require '../config'
module.exports = (app, io)->

    app.get '/', (req, res)->
        res.render 'index', layout: false, pusher: configs.domain


    [ 'publish', 'subscribe' ].map (controllerName)->
        require('./' + controllerName)(app, io)
