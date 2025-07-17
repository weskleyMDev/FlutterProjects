import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: SvgPicture.asset('assets/images/logo.svg'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail_outline_sharp),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline_sharp),
                    suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.visibility_off_outlined)),
                  ),
                ),
              ),
              const SizedBox(height: 22.0),
              ElevatedButton(onPressed: () {}, child: const Text('LOGIN')),
            ],
          ),
        ),
      ),
    );
  }
}
