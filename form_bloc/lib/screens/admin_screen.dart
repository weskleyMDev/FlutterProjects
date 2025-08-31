import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_event.dart';
import 'package:go_router/go_router.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = BlocProvider.of<AuthBloc>(context);
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: () => context.pushNamed('report-screen'),
              child: Text('New Report'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: () => print(auth.state.currentUser),
              child: Text('Show User'),
            ),
          ),
        ],
      ),
    );
  }
}
