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
      helpText: 'Selecionar Horário',
      hourLabelText: 'Hora',
      minuteLabelText: 'Minuto',
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          alwaysUse24HourFormat: true,
        ),
        child: child!,
      ),
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

  Widget _showTextField(TextEditingController? ec, String? lb, IconData? i) {
    return TextField(
      controller: ec!,
      onSubmitted: (_) => _submitForm(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          i!,
          color: Colors.lightBlue,
        ),
        labelText: lb!,
        floatingLabelStyle: const TextStyle(
          color: Colors.lightBlue,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.lightBlue,
            width: 2.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.lightBlue,
            width: 2.0,
          ),
        ),
      ),
    );
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
            left: 15.0,
            right: 15.0,
            bottom: 25.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Criar Lembrete',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(5, 40, 46, 1),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: const Color.fromRGBO(5, 40, 46, 1),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              _showTextField(
                _tituloController,
                'Título ou Remédio',
                Icons.medical_services_outlined,
              ),
              const SizedBox(
                height: 20.0,
              ),
              _showTextField(
                _descricaoController,
                'Descrição(Dosagem, Observações, ect)',
                Icons.description_outlined,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: _showHoursPicker,
                    style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(11.0),
                      backgroundColor: const Color.fromRGBO(5, 40, 46, 1),
                    ),
                    child: const Icon(
                      Icons.alarm_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  _horas == null
                      ? const Expanded(
                          child: Text(
                            'Selecione um Horário!',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromRGBO(5, 40, 46, 1),
                            ),
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
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                      backgroundColor: const Color.fromRGBO(5, 40, 46, 1),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                    ),
                    icon: const Icon(Icons.check),
                    label: const Text(
                      'SALVAR',
                      style: TextStyle(
                        fontSize: 16.0,
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
