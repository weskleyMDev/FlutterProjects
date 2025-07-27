import 'package:flutter/material.dart';

class GifDetailScreen extends StatelessWidget {
  const GifDetailScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data['title'])),
      body: ClipRRect(
        child: Image.network(
          data['images']['fixed_height']['url'],
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
