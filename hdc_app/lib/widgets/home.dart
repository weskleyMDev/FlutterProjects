import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hora de Cuidar'),
        backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(25),
                  backgroundColor: const Color.fromRGBO(209, 244, 250, 1)),
              child: const Icon(
                Icons.note_add_outlined,
                size: 40,
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
            const Text(
              'Tente escanear uma receita para ver as informações e medicamentos aqui',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.photo_camera,
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
                'Escanear Receita',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
