class Wallet {
  final String publicKey;

  Wallet({required this.publicKey});

  String get address => publicKey;
}
