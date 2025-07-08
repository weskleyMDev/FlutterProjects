import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro_mobx_app/components/cronometro_button.dart';
import 'package:pomodoro_mobx_app/store/pomodoro_store.dart';
import 'package:provider/provider.dart';

class Cronometro extends StatelessWidget {
  const Cronometro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Observer(
      builder: (_) => Container(
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              store.estaTrabalhando() ? 'Hora de Trabalhar' : 'Hora de Descansar',
              style: TextStyle(fontSize: 28.0),
            ),
            Text(
              '${store.minutos.toString().padLeft(2, '0')}:${store.segundos.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 100.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                store.iniciado
                    ? CronometroButton.pause(onTap: store.parar)
                    : CronometroButton.start(onTap: store.iniciar),
                CronometroButton.restart(onTap: store.reiniciar),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
