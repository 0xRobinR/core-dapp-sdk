class RpcCall {
  String name;
  Function handler;

  RpcCall({required this.name, required this.handler});

  String get rpcMethod => name;
}
