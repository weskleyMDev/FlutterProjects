import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_event.dart';
import 'package:go_router/go_router.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Screen'),
        actions: [
          IconButton(
            onPressed: () => auth.add(SignOutUserEvent()),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FilledButton(
          onPressed: () => context.pushNamed('report-screen'),
          child: Text('New Report'),
        ),
      ),
    );
  }
}
