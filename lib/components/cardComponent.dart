import 'package:flutter/material.dart';

class cardComponent extends StatefulWidget {
  const cardComponent({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<cardComponent> createState() => _cardComponentState();
}

class _cardComponentState extends State<cardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 50, left: 50),
      child: Card(
        elevation: 20,
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          child: widget.child,
        ),
      ),
    );
  }
}
