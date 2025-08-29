import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_event.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin Screen'),
        actions: [
          IconButton(
            onPressed: () => auth.add(SignOutUserEvent()),
            icon: Icon(Icons.logout),
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 5.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilledButton(onPressed: () {}, child: Text('New Report')),
      ),
    );
  }
}
