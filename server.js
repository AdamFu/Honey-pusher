(function() {
  var S, app, configs, express, io;

  express = require('express');

  S = require('string');

  configs = require('./config');

  app = express.createServer();

  app.listen(configs.port);

  io = require('socket.io').listen(app);

  require('./setup')(app, express, io);

  require('./controller')(app, io);

  io.sockets.on('connection', function(socket) {
    return socket.on('client-session', function(data) {
      var channel, _i, _len, _ref, _results;
      socket.join("" + data.project + ":" + data.key);
      socket.join(data.project);
      if (data.channels) {
        _ref = data.channels.split(',');
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          channel = _ref[_i];
          channel = S(channel).trim().s;
          _results.push(socket.join("" + data.project + ":channel:" + channel));
        }
        return _results;
      }
    });
  });

}).call(this);
