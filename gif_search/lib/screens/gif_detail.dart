import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GifDetailScreen extends StatelessWidget {
  const GifDetailScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gif Overview'),
        actions: [
          IconButton(
            onPressed: () async {
              final params = ShareParams(
                uri: Uri.parse(data['images']['fixed_height']['url']),
              );
              final result = await SharePlus.instance.share(params);
              if (result.status == ShareResultStatus.success) {
                print('Shared successfully!');
              } else if (result.status == ShareResultStatus.dismissed) {
                print('Shared dismissed!');
              }
            },
            icon: Icon(Icons.share_outlined),
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 8.0),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.5,
                    width: constraints.maxWidth * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        data['images']['fixed_height']['url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4.0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black87,
                      child: Center(
                        child: Text(
                          data['title'].toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
