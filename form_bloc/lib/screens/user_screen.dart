import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_event.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBloc>();
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
    );
  }
}
