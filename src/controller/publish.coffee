
justMsg = (req, res)->
    res.send 'Honey Pusher publish API'

publish = (req, res, io)->
    ###
    {from: , key: , project:, msg:, type:}
    ###
    
    data = req.body
    if data.project
        room = if data.key then "#{ data.project}:#{ data.key }" else data.project
        io.sockets.in(room).emit data.type, data.msg

    res.send req.body

module.exports = (app, io)->
    app.get '/pub', justMsg
    app.post '/pub', (req, res)-> publish req, res, io

