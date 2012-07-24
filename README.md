# How to Honey Pusher

Honey Pusher 是一个简单的消息push系统，可以很方便的应用于项目中，比如即时聊天，私信，以及订阅的Feed更新提示。

## Server Push http://pusher.hunantv.com/pub

现在支持两种push方法：

1. [msg] 此方法必须参数如下：
	* project: 'your project name'
	* type: 'msg'
	* from: 'msg send by who'
	* to: 'msg send to who'
	* body: 'msg body'
	
2. [subscribe] 此方法必须参数：
	* project: 'your project name'
	* type: 'subscribe'
	* channel: 'channel name'
	* body: 'msg body'

#### 除必须参数外，你可以添加任意的你想通过后端push到客户端的数据，客户端将收到所有参数及值。	

## Client

如何你使用[Honey](https://github.com/xydudu/Honey)你可以方便的使用如下代码下连接pusher服务以及接收到自服务端push的数据。

	honey.go('lib_socket', function() {
		var socket = io.connect('http://pusher.hunantv.com');
		socket.emit('client-session', {
			project: 'ihunantv',
			key: 'something like UID'
			channels:: 'subscribes by this client'
		});
		
		socket.on('msg', function(_data) {
			//get _data and do things 
		});
		
		socket.on('subscribe', function(_data) {
			//do things
		});
		
	});

	// mod pusher added
	honey.go('lib_jquery, lib_socket, mod_pusher', function() {
        honey.pusher({
          socket: 'http://pusher.hunantv.com',
          data: {project: 'ihunantv', key: '3', channels: 'server, tv, movie'}
        }, function(socket) {
            socket.on('subscribe', function(msg) {
            	// code here
          	});

          	socket.on('msg', function(msg) {
            	console.log(msg);
          	});
		}); 
	});



可以看到，不管是后端push还是客户问的获取信息都很简单，当然这份代码如果要上生产环境，你必要做的是，加密一些数据，以及后端push的一个认证机制，要不然，会出现很大的安全问题。



