(function() {

  module.exports = function(app, io) {
    app.error(function(err, req, res, next) {
      console.trace(err);
      return res.send(404);
    });
    app.get('/', function(req, res) {
      return res.send('Honey Pusher is running...');
    });
    return ['publish', 'subscribe'].map(function(controllerName) {
      return require('./' + controllerName)(app, io);
    });
  };

}).call(this);
