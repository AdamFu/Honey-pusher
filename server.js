(function() {
  "use strict";
  var S, app, configs, express, io;

  express = require('express');

  S = require('string');

  configs = require('./config');

  app = express.createServer();

  app.listen(configs.port, '127.0.0.1');

  io = require('socket.io').listen(app);

  require('./setup')(app, express, io);

  require('./controller')(app, io);

  require('./socket')(io);

}).call(this);
