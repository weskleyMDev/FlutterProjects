import 'package:flutter/material.dart';

class InputData extends StatefulWidget {
  const InputData({super.key});

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _weightFocus = FocusNode();
  final Map<String, dynamic> _formData = {};

  @override
  void dispose() {
    super.dispose();
    _weightFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Height',
              border: OutlineInputBorder(),
            ),
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_weightFocus),
          ),
          const SizedBox(height: 10),
          TextFormField(
            focusNode: _weightFocus,
            decoration: InputDecoration(
              labelText: 'Weight',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
