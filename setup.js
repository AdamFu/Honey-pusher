(function() {
  var middleware;

  middleware = require('./tools/middleware');

  module.exports = function(app, express, io) {
    app.use(express.bodyParser());
    app.use(express.cookieParser());
    app.use(express.session({
      secret: "honey pusher"
    }));
    app.enable('view cache');
    app.use(express.static(__dirname + '/static'));
    app.set('views', __dirname + '/view');
    app.set('view engine', 'jade');
    app.set('view options', {
      cookiesign: false
    });
    app.use(middleware.viewOption);
    return io.set('authorization', function(data, accept) {
      return accept(null, true);
    });
  };

}).call(this);
