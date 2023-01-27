class Network {
  List<String> networkRPC;
  // Gas? gas;

  Network({required this.networkRPC});

  static Network fromJson(json) {
    return Network(networkRPC: json['rpcUrls']);
  }
}
