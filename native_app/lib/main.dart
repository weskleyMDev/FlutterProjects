import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Native App',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _a = 0;
  int _b = 0;
  int _sum = 0;

  Future<void> _sumNum() async {
    const channel = MethodChannel('com.example/native');

    try {
      final sum = await channel.invokeMethod('sumNum', {'a': _a, 'b': _b});
      setState(() => _sum = sum);
    } on PlatformException {
      setState(() => _sum = 0);
    }

    setState(() => _sum = _a + _b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber, title: Text('Nativo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Digite o valor de A'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() => _a = int.tryParse(value) ?? 0);
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Digite o valor de A'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() => _b = int.tryParse(value) ?? 0);
              },
            ),
            const SizedBox(height: 12.0),
            Text(
              'Soma: $_sum',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(onPressed: _sumNum, child: const Text('Somar')),
          ],
        ),
      ),
    );
  }
}
