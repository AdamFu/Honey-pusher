# publish
justMsg = (req, res)->
    res.send 'Honey Pusher publish API'

publish = (req, res, io)->
    ###
    Subscribe:
        project: 'project name. eg: ihunantv'
        channel: 'channel name. eg: a movie id'
        body: 'message body'

    Message:
        project: 'project name. eg: ihunantv'
        from: 'msg send from who'
        to: 'msg send to who'
        body: 'message body'
    ###
     
    data = req.body
    if data.project
        ###
        Get room name
        ###
        if data.type is 'subscribe'
            room = "#{data.project}:channel:#{data.channel}"
        else
            room = if data.key then "#{ data.project}:#{ data.key }" else data.project
        io.sockets.in(room).emit data.type, data

    res.send req.body

module.exports = (app, io)->
    app.get '/pub', justMsg
    app.post '/pub', (req, res)-> publish req, res, io

