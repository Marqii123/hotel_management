import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  final String title;
  const BlankPage(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "$title Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
