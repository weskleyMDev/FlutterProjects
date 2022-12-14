import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hdc_app/models/lembrete.dart';
import 'package:hdc_app/widgets/alarm_form.dart';
import 'package:hdc_app/widgets/alarm_list.dart';

class AlarmesHome extends StatefulWidget {
  const AlarmesHome({super.key});

  @override
  State<AlarmesHome> createState() => _AlarmesHomeState();
}

class _AlarmesHomeState extends State<AlarmesHome> with WidgetsBindingObserver {
  final List<Lembrete> _lembretes = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  _addLembrete(String titulo, String desc, String horas) {
    final newLembrete = Lembrete(
      id: Random().nextInt(100),
      titulo: titulo,
      desc: desc,
      horas: horas,
    );

    setState(() {
      _lembretes.add(newLembrete);
    });

    Navigator.of(context).pop();
  }

  _deleteLembrete(int id) {
    setState(() {
      _lembretes.removeWhere((lb) => lb.id == id);
    });
  }

  _abrirAlarmeModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) => AlarmeForm(_addLembrete),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final altResp = mediaQuery.size.height - mediaQuery.padding.top;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: altResp * 0.6,
              child: AlarmeLista(
                _lembretes,
                _deleteLembrete,
                _abrirAlarmeModal,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () {
                _abrirAlarmeModal(context);
              },
              icon: const Icon(
                Icons.notifications_active_outlined,
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
                'ADICIONAR LEMBRETE',
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
