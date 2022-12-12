import 'package:flutter/material.dart';
import 'package:hdc_app/widgets/alarm_modal.dart';

import 'tabs.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const String routeName = '/home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
      appBar: null,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              right: 10.0,
              left: 10.0,
              top: 30.0,
              bottom: 5.0 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'CPF',
                    prefixIcon: Icon(
                      Icons.person_outline_sharp,
                      color: Colors.lightBlue,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelStyle: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.lightBlue,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.lightBlue,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(
                      Icons.password_rounded,
                      color: Colors.lightBlue,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelStyle: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.lightBlue,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.lightBlue,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Esqueci Minha Senha',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(TabScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(5, 40, 46, 1),
                    shape: const StadiumBorder(),
                    fixedSize: const Size(320.0, 50.0),
                  ),
                  icon: const Icon(
                    Icons.login_rounded,
                  ),
                  label: const Text(
                    'FAZER LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text(
                  'Não tem uma conta? Cadastre-se',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
