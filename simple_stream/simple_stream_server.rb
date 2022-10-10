this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'simple_stream_services_pb'


class EchoServicer < StreamingEcho::Service
  # @params [GRPC::ActiveCall::MultiReqView] call
  def echo(call)
    arr = []
    call.each_remote_read do |row|
      arr.push(row.msg)
    end
    puts 'finished'
    EchoMessage.new(msg: "got message: #{arr.join(',')}")
  end
end

def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(EchoServicer)
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
