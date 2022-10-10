project rootで実施

```
// edit proto
vim protos/file.prod

// protoファイルからサービスを生成
bundle exec grpc_tools_ruby_protoc -I protos --ruby_out=lib --grpc_out=lib protos/file.proto
```

```
bundle exec ruby import_stream_server.rb 

// another terminal
bundle exec ruby import_stream_client.rb test.csv

// output
"1"
52500
"20750e6f-a4b8-4b81-929c-8c118f120242.csv"
```
