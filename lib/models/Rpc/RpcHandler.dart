class RpcHandler {
  final List<dynamic> args;
  final Function handler;
  RpcHandler({required this.args, required this.handler});

  List<dynamic> get rpcArgs => args;
  Function get rpcHandler => handler;
}
