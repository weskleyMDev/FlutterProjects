import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../utils/routes.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initSplashScreen();
  }

  void _initSplashScreen() {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200.0,
              ),
              const SizedBox(
                height: 30.0,
              ),
              const ListTile(
                title: Text(
                  'TREASURE SEARCH BATTLE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
                subtitle: Text(
                  'Pirates Edition',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    AppRoutes.navigatorKey!.currentState!
                        .pushNamed(PlayerScreen.route);
                  },
                  icon: const Icon(
                    Icons.play_circle_outline,
                  ),
                  label: const Text(
                    'INICIAR',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    backgroundColor: Colors.blueGrey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
