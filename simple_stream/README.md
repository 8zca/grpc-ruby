# client-server-streaming

project rootで実施

```
// edit proto
vim protos/simple_strem.prod

bundle exec grpc_tools_ruby_protoc -I protos --ruby_out=lib --grpc_out=lib protos/simple_stream.pro
```

```
bundle exec ruby simple_stream_server.rb 

// another terminal
bundle exec ruby simple_stream_client.rb

// output
got message: number 1,number 2,number 3,number 4,number 5
```
