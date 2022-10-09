project rootで実施

```
// edit proto
vim protos/add.prod

// lib配下にadd_pb.rb, add_services_pd.rbができる
bundle exec grpc_tools_ruby_protoc -I protos --ruby_out=lib --grpc_out=lib protos/add.proto
```
