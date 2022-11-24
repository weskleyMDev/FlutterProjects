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
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(231, 249, 251, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 15.0,
            left: 10.0,
            right: 10.0,
            bottom: 20.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Criar Lembrete',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(5, 40, 46, 1),
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
                height: 10.0,
              ),
              TextField(
                controller: _tituloController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.medical_services_outlined,
                    color: Colors.lightBlue,
                  ),
                  labelText: 'Título ou Remédio',
                  floatingLabelStyle: TextStyle(
                    color: Color.fromRGBO(5, 40, 46, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: _descricaoController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.description_outlined,
                    color: Colors.lightBlue,
                  ),
                  labelText: 'Descrição(Dosagem, Observações, ect)',
                  floatingLabelStyle: TextStyle(
                    color: Color.fromRGBO(5, 40, 46, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: _showHoursPicker,
                    style: IconButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12.0),
                      backgroundColor: const Color.fromRGBO(5, 40, 46, 1),
                    ),
                    child: const Icon(
                      Icons.alarm_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  _horas == null
                      ? const Text(
                          'Selecione um Horário!',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color.fromRGBO(5, 40, 46, 1),
                          ),
                        )
                      : Text(
                          '$_horas',
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Color.fromRGBO(5, 40, 46, 1),
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 10.0,
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
                  ),
                  backgroundColor: const Color.fromRGBO(5, 40, 46, 1),
                ),
                icon: const Icon(Icons.check),
                label: const Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 16.0,
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
