import 'package:flutter/material.dart';

import '../components/insert_bar.dart';
import '../components/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TASKs')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.15,
                    width: constraints.maxWidth * 0.9,
                    child: const CustomInsertBar(),
                  ),
                  Expanded(child: CustomTodoList()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
