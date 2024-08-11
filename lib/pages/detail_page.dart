import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  int id;
  String title;

  DetailPage({super.key, required this.id, required this.title});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DetailPage"),
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Text(widget.id.toString()),
          Text(widget.title),
        ],
      ),
    );
  }
}
