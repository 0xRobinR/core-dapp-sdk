import 'package:flutter/material.dart';

class AddChain extends StatelessWidget {
  final String addChain;
  final String webTitle;
  final Function() onAccept;
  final Function() onReject;

  const AddChain(
      {Key? key,
      required this.addChain,
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
          const Text("Add Chain Request"),
          Text("$webTitle App has requested to add chain $addChain"),
          Row(
            children: [
              ElevatedButton(onPressed: onReject, child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: onAccept, child: const Text("Add Network")),
            ],
          )
        ],
      ),
    );
  }
}
