import 'package:flutter/material.dart';

class LegalDocumentPage extends StatelessWidget {
  const LegalDocumentPage({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(body, style: const TextStyle(fontSize: 15, height: 1.5)),
        ],
      ),
    );
  }
}
