import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:treasure_game/custom_icons_icons.dart';

import '../data/cartas_dummy.dart';
import '../data/dummy_cartas.dart';
import '../models/cartas_map.dart';
import '../widgets/fight_modal.dart';
import '../widgets/item_carta.dart';
import '../widgets/rules_modal.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  static const route = '/player';

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  Widget? _cartas;
  final List<Widget> _iconsVidas = [
    const Icon(
      Icons.heart_broken,
      color: Colors.red,
    ),
    const Icon(
      Icons.heart_broken,
      color: Colors.red,
    ),
    const Icon(
      Icons.heart_broken,
      color: Colors.red,
    ),
    const Icon(
      Icons.heart_broken,
      color: Colors.red,
    ),
  ];

  String _index = '';
  final List<String> _opt = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
  ];

  int _pontos = 0;
  int _start = 10;
  String _numberDice = '1';
  String _letterDice = 'A';
  bool _activate = false;
  final List<String> _repeat = [];
  String _elem = '';
  int _cont = 72;
  final List<CartasMap> _map = dummyCartasMap;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _readQrCode() async {
    String code;

    try {
      code = await FlutterBarcodeScanner.scanBarcode(
        '#ffffff',
        'Cancelar',
        false,
        ScanMode.QR,
      );
    } on PlatformException {
      code = 'QR inválido';
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _index = code != '-1' ? code : '';
    });

    switch (_index) {
      case '0':
        AwesomeDialog(
          context: context,
          animType: AnimType.bottomSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.infoReverse,
          body: _showCards(int.parse(_index)),
          btnOkOnPress: () {
            setState(() {
              if (_pontos <= 8) {
                _addCartas(int.parse(_index));
                _pontos += 2;
              } else {
                _addCartas(int.parse(_index));
                _pontos++;
              }
            });
            if (_pontos == 10) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                headerAnimationLoop: false,
                animType: AnimType.leftSlide,
                title: 'VITÓRIA!',
                desc: 'VOCÊ FOI O VENCEDOR DESTA PARTIDA!',
                btnOkOnPress: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/home'));
                },
                dismissOnTouchOutside: false,
                dismissOnBackKeyPress: false,
              ).show();
            }
          },
          btnOkColor: Colors.blue[500],
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          barrierColor: Colors.blueGrey[900]?.withOpacity(0.54),
        ).show();
        break;
      case '1':
        AwesomeDialog(
          context: context,
          animType: AnimType.bottomSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.infoReverse,
          body: _showCards(int.parse(_index)),
          btnOkOnPress: () {
            setState(() {
              _addCartas(int.parse(_index));
              _pontos++;
            });
            if (_pontos == 10) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                headerAnimationLoop: false,
                animType: AnimType.leftSlide,
                title: 'VITÓRIA!',
                desc: 'VOCÊ FOI O VENCEDOR DESTA PARTIDA!',
                btnOkOnPress: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/home'));
                },
                dismissOnTouchOutside: false,
                dismissOnBackKeyPress: false,
              ).show();
            }
          },
          btnOkColor: Colors.blue[500],
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          barrierColor: Colors.blueGrey[900]?.withOpacity(0.54),
        ).show();
        break;
      case '2':
        AwesomeDialog(
          context: context,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.question,
          body: _showCards(int.parse(_index)),
          btnOkOnPress: () {
            if (_iconsVidas.length == 6) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                headerAnimationLoop: false,
                animType: AnimType.topSlide,
                title: 'VIDAS!',
                desc: 'LIMITE MÁXIMO ATINGIDO!',
                btnOkOnPress: () {},
                btnOkColor: Colors.red[700],
                dismissOnTouchOutside: false,
                dismissOnBackKeyPress: false,
              ).show();
            } else {
              setState(() {
                _addCartas(int.parse(_index));
                _iconsVidas.add(
                  const Icon(
                    Icons.heart_broken,
                    color: Colors.red,
                  ),
                );
              });
            }
          },
          btnOkColor: Colors.orange[700],
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          barrierColor: Colors.blueGrey[900]?.withOpacity(0.54),
        ).show();

        break;
      case '3':
        AwesomeDialog(
          context: context,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.error,
          body: _showCards(int.parse(_index)),
          btnOkOnPress: () {
            setState(() {
              _addCartas(int.parse(_index));
              _iconsVidas.removeLast();
            });
            if (_iconsVidas.isEmpty) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                headerAnimationLoop: false,
                animType: AnimType.topSlide,
                title: 'DERROTA!',
                desc: 'VOCÊ PERDEU ESTA PARTIDA!',
                btnOkOnPress: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/home'));
                },
                btnOkColor: Colors.yellow[700],
                dismissOnTouchOutside: false,
                dismissOnBackKeyPress: false,
              ).show();
            }
          },
          btnOkColor: Colors.red[700],
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          barrierColor: Colors.blueGrey[900]?.withOpacity(0.54),
        ).show();
        break;
      case '4':
        AwesomeDialog(
          context: context,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          dialogType: DialogType.question,
          body: _showCards(int.parse(_index)),
          btnOkOnPress: () {
            setState(() {
              _addCartas(int.parse(_index));
            });
          },
          btnOkColor: Colors.orange[700],
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          barrierColor: Colors.blueGrey[900]?.withOpacity(0.54),
        ).show();
        break;
      default:
        return;
    }
  }

  _changeDice() {
    setState(() {
      if (_repeat.isEmpty) {
        _numberDice = (Random().nextInt(12) + 1).toString();
        _letterDice = _opt[Random().nextInt(6)];
        _elem = _numberDice + _letterDice;
        _repeat.add(_elem);
      } else if (_repeat.length < 72) {
        do {
          _numberDice = (Random().nextInt(12) + 1).toString();
          _letterDice = _opt[Random().nextInt(6)];
          _elem = _numberDice + _letterDice;
        } while (_repeat.contains(_elem));
        _repeat.add(_elem);
      }
    });
  }

  Widget _showCards(int index) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Image.asset(
            dummyCartas[index].image,
          ),
          title: Text(
            dummyCartas[index].titulo,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            dummyCartas[index].descricao,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  _addCartas(int index) {
    _cartas = _showCards(index);
  }

  _showFigthModal() {
    showModalBottomSheet(
        elevation: 5.0,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) {
          return WillPopScope(
            child: FightModal(_vitoriaBatalha, _derrotaBatalha),
            onWillPop: () async {
              return false;
            },
          );
        });
  }

  _showRulesModal() {
    showModalBottomSheet(
        elevation: 5.0,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return const RulesModal();
        });
  }

  _vitoriaBatalha(int p) {
    setState(() {
      _pontos += p;
      if (_pontos == 10) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.leftSlide,
          title: 'VITÓRIA!',
          desc: 'VOCÊ FOI O VENCEDOR DESTA PARTIDA!',
          btnOkOnPress: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/home'));
          },
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
        ).show();
      }
    });
  }

  _derrotaBatalha(int p) {
    setState(() {
      if (_pontos > 0) {
        _pontos -= p;
      } else {
        _iconsVidas.removeLast();
        if (_iconsVidas.isEmpty) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            headerAnimationLoop: false,
            animType: AnimType.topSlide,
            title: 'DERROTA!',
            desc: 'VOCÊ PERDEU ESTA PARTIDA!',
            btnOkOnPress: () {
              Navigator.of(context).popUntil(ModalRoute.withName('/home'));
            },
            btnOkColor: Colors.yellow[700],
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
          ).show();
        }
      }
    });
  }

  _startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          _start = 10;
          _activate = !_activate;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  _cardDecrement() {
    setState(() {
      _cont--;
    });
  }

  _showMapModal() {
    showModalBottomSheet(
      elevation: 5.0,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.52,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/mapa.png',
                  ),
                  opacity: 0.6,
                  fit: BoxFit.cover),
            ),
            child: GridView.count(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              crossAxisCount: 12,
              children: dummyCartasMap
                  .map(
                    (e) => ItemCarta(carta: e),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  String _anterior = 'A1';
  String _proximo = '';

  _showPositionMap() {
    for (var elem in _map) {
      if (elem.id == _anterior) {
        setState(() {
          elem.color = Colors.transparent;
          elem.font = Colors.black;
        });
      }
    }
    _proximo = '$_letterDice$_numberDice';
    for (var elem in _map) {
      if (elem.id == _proximo) {
        setState(() {
          elem.color = Colors.blue.shade900;
          elem.font = Colors.white;
          _anterior = _proximo;
        });
      }
    }
    _anterior = _proximo;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: const Text('Treasure S. Battle'),
        actions: [
          IconButton(
            onPressed: _showMapModal,
            icon: const Icon(CustomIcons.map),
          ),
          IconButton(
            onPressed: _showFigthModal,
            icon: const Icon(CustomIcons.crossed_swords),
          ),
          PopupMenuButton(
            onSelected: (value) {
              (value == 'open_modal')
                  ? _showRulesModal()
                  : throw UnimplementedError();
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'open_modal',
                child: Text('Regras'),
              ),
            ],
            elevation: 5.0,
            position: PopupMenuPosition.under,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: mediaQuery.size.height,
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 12.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/pirate_ship.png',
              ),
              opacity: 0.6,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'PONTOS: $_pontos',
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'CARTAS: ${_cont.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22.0),
                  child: Row(
                    children: [
                      const Text(
                        'VIDAS:',
                        style: TextStyle(
                          fontSize: 19.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Row(
                        children: _iconsVidas,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 25.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'ÚLTIMA CARTA LIDA',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        child: _cartas,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/dice_$_letterDice.png',
                      height: 80.0,
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/dice_$_numberDice.png',
                      height: 100.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              (_repeat.length < 72)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton.icon(
                          onPressed: (_activate)
                              ? null
                              : () {
                                  _activate = !_activate;
                                  _cardDecrement();
                                  _changeDice();
                                  _showPositionMap();
                                  _startTimer();
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.blueGrey[700],
                          ),
                          icon: const Icon(CustomIcons.dice),
                          label: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'ROLAR DADOS | ${_start.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: _readQrCode,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.blueGrey[700],
                          ),
                          icon: const Icon(Icons.qr_code_scanner),
                          label: const Text(
                            'ESCANEAR CARTA',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.blueGrey[700],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'NÃO HÁ MAIS CARTAS',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.blueGrey[700],
                          ),
                          icon: const Icon(Icons.qr_code_scanner),
                          label: const Text(
                            'ESCANEAR CARTA',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
