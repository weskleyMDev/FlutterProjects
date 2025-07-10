import 'package:counter_app/contracts/icounter.dart';
import 'package:counter_app/providers/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [ChangeNotifierProvider<ICounter>(create: (_) => Counter())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Counter App',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple.shade700,
            secondary: Colors.black87,
          ),
          textTheme: theme.textTheme.copyWith(
            displayMedium: theme.textTheme.displayMedium?.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: const [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(4, 0),
                ),
              ],
            ),
            displayLarge: theme.textTheme.displayLarge?.copyWith(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: const [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(4, 0),
                ),
              ],
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: Colors.white.withValues(alpha: 0.6),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fixedSize: const Size(80.0, 80.0),
              padding: const EdgeInsets.all(8.0),
              elevation: 5.0,
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            Consumer<ICounter>(
              builder: (context, count, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (child != null) child,
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Text(
                      count.counter.toString(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: count.counter == 0 ? null : count.decrement,
                        child: const Text(
                          'SAIR',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      const SizedBox(width: 18.0),
                      ElevatedButton(
                        onPressed: count.counter == 10 ? null : count.increment,
                        child: const Text(
                          'ENTRAR',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              child: Text(
                'Pode entrar'.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
