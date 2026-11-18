require 'webrick'

server = WEBrick::HTTPServer.new(
  Port: 8080,
  Logger: WEBrick::Log.new($stdout, WEBrick::Log::INFO),
  AccessLog: [[$stdout, WEBrick::AccessLog::COMBINED_LOG_FORMAT]]
)

trap('INT') { server.shutdown }

server.mount_proc '/' do |req, res|
  res['Access-Control-Allow-Origin'] = '*'
  res.content_type = 'text/html; charset=utf-8'
  res.body = File.read(File.join(__dir__, 'index.html'))
end

puts "DSP Birthday website running at http://localhost:8080"
server.start

