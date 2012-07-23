(function() {
  "use strict";
  var S, app, configs, express, io;

  express = require('express');

  S = require('string');

  configs = require('./config');

  app = express.createServer();

  app.listen(configs.port);

  io = require('socket.io').listen(app);

  require('./socket')(io);

  require('./setup')(app, express, io);

  require('./controller')(app, io);

}).call(this);
