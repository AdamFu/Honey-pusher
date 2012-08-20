console.info("Socket.io chat test client");
io = require('socket.io-client');

for (var socket_n = 0; socket_n < 500; socket_n++) {

    (function() {

        var j = socket_n;

        socket = io.connect('http://honey.hunantv.com:8888', {'force new connection': true});
        socket.my_nick = process.pid.toString() + "_" + j.toString();
        socket.emit('client-session', {
                project: 'ihunantv',
                key: 123,
                channels: 'tv_s_980'
            });

        (function() {
            var inner_socket = socket;
            inner_socket.on('connect', function () {
                console.info("Connected[" + j + "] => " + inner_socket.my_nick);

                //inner_socket.emit('nickname', inner_socket.my_nick, function (set) { });

                //var interval = Math.floor(Math.random()*10001) + 5000;
                //setInterval(function() {
                //    inner_socket.emit('user message', "Regular timer message every " + interval + " ms");
                //}, interval);
            });
        })();

        socket.on('msg', function () {
            console.info('msg ...sent');
        });
        socket.on('user message', function (from, msg) {
            console.info(from + "::" + msg);
        });

        socket.socket.on('error', function (err_msg) {
            console.error("Connection Error:" + err_msg);
        });

        //socket.on('nicknames', function (nicknames) {
        //    var number_of_users = 0;
        //    for (var i in nicknames) {
        //        number_of_users++;
        //    }
        //    console.info("There are " + number_of_users + " users logged in.");
        //});

        //socket.on('announcement', function (msg) {
        //    console.info("ANN: " + msg);
        //});

        socket.on('disconnect', function () {
            console.info("Disconnected");
        });
    })();
}
