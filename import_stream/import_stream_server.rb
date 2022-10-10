this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'import_services_pb'
require 'SecureRandom'

class ImportServicer < Import::Upload::Service
  # @params [GRPC::ActiveCall::MultiReqView] call
  def send(call)
    uuid = SecureRandom.uuid
    id = ''
    size = 0
    ext = ''
    call.each_remote_read do |request|
      if request.file_info
        id = request.file_info.id
        ext = request.file_info.file_ext
        next
      end

      File.open(uuid + ext, 'w') do |io|
        io.write(request.chunk_data)
        size += io.size
      end
    end

    p 'finished'

    Import::UploadResponse.new(id: id, size: size, output: uuid + ext)
  end
end

def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(ImportServicer)
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
