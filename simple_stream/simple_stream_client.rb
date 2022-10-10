this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'simple_stream_services_pb'

def main
  stub = StreamingEcho::Stub.new('localhost:50051', :this_channel_is_insecure)

  arr = []
  (1..5).each do |i|
    arr.push(EchoMessage.new(msg: "number #{i}"))
  end
  res = stub.echo(arr.each)
  puts res.msg
end

main
