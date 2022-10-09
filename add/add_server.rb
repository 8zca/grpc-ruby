this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'add_services_pb'


class AddServer < Calc::Add::Service
  def add(input, _unused_call)
    answer = input.number + 1

    return Calc::AddResponse.new(answer: answer)
  end
end

def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(AddServer)
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
