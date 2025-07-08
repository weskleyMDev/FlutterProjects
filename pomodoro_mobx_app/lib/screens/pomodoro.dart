import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro_mobx_app/components/cronometro.dart';
import 'package:pomodoro_mobx_app/components/entrada_tempo.dart';
import 'package:pomodoro_mobx_app/store/pomodoro_store.dart';
import 'package:provider/provider.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Cronometro()),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              child: Observer(
                builder: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EntradaTempo(
                      valor: store.tempoTrabalho,
                      titulo: 'Trabalho',
                      increment: store.iniciado && store.estaTrabalhando()
                          ? null
                          : store.incrementarTrabalho,
                      decrement: store.iniciado && store.estaTrabalhando()
                          ? null
                          : store.decrementarTrabalho,
                    ),
                    EntradaTempo(
                      valor: store.tempoDescanso,
                      titulo: 'Descanso',
                      increment: store.iniciado && store.estaDescansando()
                          ? null
                          : store.incrementarDescanso,
                      decrement: store.iniciado && store.estaDescansando()
                          ? null
                          : store.decrementarDescanso,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
