import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/notify_manager.dart';

class AlarmeForm extends StatefulWidget {
  const AlarmeForm(this.onSubmit, {super.key});

  final void Function(String, String, String) onSubmit;

  @override
  State<AlarmeForm> createState() => _AlarmeFormState();
}

class _AlarmeFormState extends State<AlarmeForm> {
  final DateTime _dataAtual = DateTime.now();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  String? _horas;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    NotifyManager.initNotification();
  }

  _submitForm() {
    final titulo = _tituloController.text;
    final descricao = _descricaoController.text;

    if (titulo.isEmpty || descricao.isEmpty || _horas == null) {
      return;
    }
    widget.onSubmit(titulo, descricao, _horas!);
  }

  _showHoursPicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _horas =
            '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String dataFormatada = DateFormat('y-MM-dd').format(_dataAtual);
    return SafeArea(
      child: Container(
        height: 550.0,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(231, 249, 251, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Criar Lembrete',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: Colors.blueGrey[900],
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 35.0,
              ),
              TextField(
                controller: _tituloController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título ou Remédio',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _descricaoController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descrição(Dosagem, Observações, ect)',
                ),
              ),
              const SizedBox(
                height: 45.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: _showHoursPicker,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                    ),
                    icon: const Icon(Icons.alarm_rounded),
                    label: const Text('Hora'),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    _horas == null ? 'Nenhum Horário Selecionado!' : '$_horas',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35.0,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await NotifyManager.showNotification(
                    title: _tituloController.text,
                    body: _descricaoController.text,
                    payload: _tituloController.text,
                    data: '$dataFormatada $_horas:00',
                  );
                  _submitForm();
                },
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 55.0,
                      vertical: 10.0,
                    )),
                icon: const Icon(Icons.check),
                label: const Text(
                  'Salvar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
