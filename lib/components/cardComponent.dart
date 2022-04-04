import 'dart:ffi';

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
    double wi = MediaQuery.of(context).size.width * 0.1;
    return Container(
      margin: EdgeInsets.only(top: 10, right: wi, left: wi),
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
