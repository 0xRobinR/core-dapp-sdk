import 'package:flutter/material.dart';

class ChainSwitch extends StatelessWidget {
  final String currentChain;
  final String switchChain;
  final String webTitle;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ChainSwitch(
      {Key? key,
      required this.currentChain,
      required this.switchChain,
      required this.webTitle,
      required this.onAccept,
      required this.onReject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Chain Switch Request"),
          Text(
              "$webTitle App has requested chain switch from $currentChain to $switchChain"),
          Row(
            children: [
              ElevatedButton(onPressed: onReject, child: const Text("Cancel")),
              ElevatedButton(onPressed: onAccept, child: const Text("Switch")),
            ],
          )
        ],
      ),
    );
  }
}
