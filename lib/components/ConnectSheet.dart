import 'package:flutter/material.dart';

class ConnectSheet extends StatelessWidget {
  final Function() onPressed;
  final Function() onReject;
  const ConnectSheet(
      {Key? key, required this.onPressed, required this.onReject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          TextButton(onPressed: onPressed, child: const Text("Connect")),
          TextButton(onPressed: onReject, child: const Text("Reject")),
        ],
      ),
    );
  }
}
