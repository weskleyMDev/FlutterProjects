import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'store/counter.store.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CounterStore>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pode entrar'.toUpperCase(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Observer(
                    builder: (_) => Text(
                      store.count.toString(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Observer(
                      builder: (_) => ElevatedButton(
                        onPressed: store.count == 0 ? null : store.decrement,
                        child: const Text(
                          'SAIR',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18.0),
                    Observer(
                      builder: (_) => ElevatedButton(
                        onPressed: store.count == 10 ? null : store.increment,
                        child: const Text(
                          'ENTRAR',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
