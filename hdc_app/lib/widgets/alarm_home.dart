import 'package:flutter/material.dart';

import 'alarm_modal.dart';

class AlarmesHome extends StatelessWidget {
  const AlarmesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
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
                Icons.alarm,
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Adicione um alarme e te avisaremos quando for a hora de tomar a dose do seu remédio',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: ((context) {
                    return const AlarmModal();
                  }),
                );
              },
              icon: const Icon(
                Icons.alarm,
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
                'Adiconar Alarme',
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
