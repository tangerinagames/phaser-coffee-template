connect = require "connect"
http = require "http"
path = require "path"
gzippo = require "gzippo"

port = process.env.PORT or 3000
directory = path.resolve "dist"

app = connect()
  .use gzippo.staticGzip directory
  .use connect.directory directory

http.createServer(app).listen port
