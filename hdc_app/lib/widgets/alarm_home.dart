import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hdc_app/models/lembrete.dart';
import 'package:hdc_app/services/notify_manager.dart';
import 'package:hdc_app/widgets/alarm_form.dart';
import 'package:hdc_app/widgets/alarm_list.dart';

class AlarmesHome extends StatefulWidget {
  const AlarmesHome(this.notificationAppLaunchDetails, {super.key});

  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

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
      builder: (_) => AlarmeForm(_addLembrete, NotifyManager.notificationAppLaunchDetails),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 400.0,
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
      ),
    );
  }
}
