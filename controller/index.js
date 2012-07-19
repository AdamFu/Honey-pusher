(function() {

  module.exports = function(app, io) {
    app.error(function(err, req, res, next) {
      console.trace(err);
      return res.send(404);
    });
    app.get('/', function(req, res) {
      return res.render('index', {
        layout: false,
        key: 1
      });
    });
    app.get('/client2', function(req, res) {
      return res.render('index', {
        layout: false,
        key: 2
      });
    });
    return ['publish', 'subscribe'].map(function(controllerName) {
      return require('./' + controllerName)(app, io);
    });
  };

}).call(this);
