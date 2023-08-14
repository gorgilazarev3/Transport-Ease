import 'package:flutter/material.dart';

void main() {
  runApp(const TransportEaseApp());
}

class TransportEaseApp extends StatelessWidget {
  const TransportEaseApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "TransportEase",
      home: Text("TransportEase App"),
    );
  }
}


