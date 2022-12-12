import 'dart:math';

import 'package:flutter/material.dart';
import 'package:treasure_game/custom_icons_icons.dart';

import '../utils/routes.dart';

class FightModal extends StatefulWidget {
  const FightModal(this.vitoriaBatalha, this.derrotaBatalha, {super.key});

  final dynamic Function(int) vitoriaBatalha;
  final dynamic Function(int) derrotaBatalha;

  @override
  State<FightModal> createState() => _FightModalState();
}

class _FightModalState extends State<FightModal> {
  int _player1 = 1;
  bool _inativo = false;
  bool _visible = false;
  bool _close = false;

  @override
  Widget build(BuildContext context) {
    int dado1 = Random().nextInt(12) + 1;
    return SingleChildScrollView(
      child: Card(
        color: Colors.blueGrey[200],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 15.0,
            left: 10.0,
            right: 10.0,
            bottom: 10.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Você Iniciou uma Batalha!',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: (_close)
                        ? null
                        : () {
                            AppRoutes.navigatorKey!.currentState!.pop();
                          },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(
                height: 30.0,
                color: Colors.black,
                thickness: 1.2,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/dice_$_player1.png',
                      height: 100.0,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: _inativo,
                child: Column(
                  children: [
                    const Text(
                      'QUAL FOI O RESULTADO?',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: (_visible)
                              ? null
                              : () {
                                  setState(() {
                                    _visible = !_visible;
                                    _close = !_close;
                                  });
                                  widget.derrotaBatalha(1);
                                },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.red,
                          ),
                          icon:
                              const Icon(Icons.sentiment_dissatisfied_rounded),
                          label: const Text(
                            'DERROTA',
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: (_visible)
                              ? null
                              : () {
                                  setState(() {
                                    _visible = !_visible;
                                    _close = !_close;
                                  });
                                  widget.vitoriaBatalha(1);
                                },
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.green[600],
                          ),
                          icon: const Icon(
                              Icons.sentiment_very_satisfied_rounded),
                          label: const Text(
                            'VITÓRIA',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: (_visible)
                          ? null
                          : () {
                              setState(() {
                                _visible = !_visible;
                                _close = !_close;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.amber[400]),
                      icon: const Icon(Icons.sentiment_dissatisfied),
                      label: const Text(
                        'EMPATE',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  backgroundColor: Colors.blueGrey[900],
                ),
                onPressed: (_inativo)
                    ? null
                    : () {
                        setState(() {
                          _player1 = dado1;
                          _inativo = !_inativo;
                          _close = !_close;
                        });
                      },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(CustomIcons.dice),
                ),
                label: const Text('ROLAR DADO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
