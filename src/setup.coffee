middleware = require './tools/middleware'
module.exports = (app, express, io)->

    app.use express.bodyParser()
    app.use express.cookieParser()
    app.use express.session secret: "honey pusher"
    app.enable 'view cache'
    app.use express.static(__dirname + '/static')
    app.set 'views', __dirname + '/view'
    app.set 'view engine', 'jade'
    app.set 'view options', {
        cookiesign: false
    }

    app.use middleware.viewOption
    io.set 'authorization', (data, accept)->
        accept null, true
