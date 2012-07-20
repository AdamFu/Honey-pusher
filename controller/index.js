(function() {
  var configs;

  configs = require('../config');

  module.exports = function(app, io) {
    app.error(function(err, req, res, next) {
      console.trace(err);
      return res.send(404);
    });
    app.get('/', function(req, res) {
      return res.render('index', {
        layout: false,
        pusher: configs.domain
      });
    });
    return ['publish', 'subscribe'].map(function(controllerName) {
      return require('./' + controllerName)(app, io);
    });
  };

}).call(this);
