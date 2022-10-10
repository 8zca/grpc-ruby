# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: import.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("import.proto", :syntax => :proto3) do
    add_message "import.FileInfo" do
      optional :id, :string, 1
      optional :file_ext, :string, 2
    end
    add_message "import.UploadRequest" do
      oneof :file do
        optional :file_info, :message, 1, "import.FileInfo"
        optional :chunk_data, :bytes, 2
      end
    end
    add_message "import.UploadResponse" do
      optional :id, :string, 1
      optional :size, :int32, 2
      optional :output, :string, 3
    end
  end
end

module Import
  FileInfo = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("import.FileInfo").msgclass
  UploadRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("import.UploadRequest").msgclass
  UploadResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("import.UploadResponse").msgclass
end