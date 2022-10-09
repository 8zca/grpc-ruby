this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'add_services_pb'

def main
  number = ARGV[0]&.to_i || 0
  stub = Calc::Add::Stub.new('localhost:50051', :this_channel_is_insecure)

  answer = stub.add(Calc::AddRequest.new(number: number)).answer
  p "Answer: #{answer}"
end

main
