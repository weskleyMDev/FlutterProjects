import 'package:flutter/material.dart';

class ReceitasHome extends StatefulWidget {
  const ReceitasHome({super.key});

  @override
  State<ReceitasHome> createState() => _ReceitasHomeState();
}

class _ReceitasHomeState extends State<ReceitasHome> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final altResp = mediaQuery.size.height - mediaQuery.padding.top;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: altResp * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(25),
                        backgroundColor:
                            const Color.fromRGBO(209, 244, 250, 1)),
                    child: const Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 40.0,
                      color: Color.fromRGBO(5, 40, 46, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Não Há Nada Aqui',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text(
                    'Tente escanear uma receita para ver as informações e medicamentos aqui',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed('/qrscan');
            },
            icon: const Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 35,
              ),
              backgroundColor: const Color.fromRGBO(5, 40, 46, 1),
            ),
            label: const Text(
              'ESCANEAR RECEITA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
