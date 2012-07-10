module.exports = (app, io)->

    app.error (err, req, res, next)->
        # store msg to logfile
        console.trace(err)
        res.send 404

    app.get '/', (req, res)->
        res.render 'index', layout: false, key: 1

    app.get '/client2', (req, res)->
        res.render 'index', layout: false, key: 2

    [ 'publish', 'subscribe' ].map (controllerName)->
        require('./' + controllerName)(app, io)
