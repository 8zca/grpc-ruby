this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'import_services_pb'

CHUNK_SIZE = 1024

def main
  filename = ARGV[0]
  abort("please input filename.") unless filename

  stub = Import::Upload::Stub.new('localhost:50051', :this_channel_is_insecure)

  buffs = Enumerator.new do |y|
    file_info = Import::FileInfo.new(id: '1', file_ext: File.extname(filename))
    y << Import::UploadRequest.new(file_info: file_info)

    File.open(filename, 'rb') do |io|      
      while buff = io.read(CHUNK_SIZE)
        y << Import::UploadRequest.new(chunk_data: buff)
      end
    end
  end

  res = stub.send(buffs)

  p res.id
  p res.size
  p res.output
end

main
