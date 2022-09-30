import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacaoForm extends StatefulWidget {
  const TransacaoForm(this.onSubmit, {super.key});

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransacaoForm> createState() => _TransacaoFormState();
}

class _TransacaoFormState extends State<TransacaoForm> {
  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();
  DateTime? _dataSelecionada = DateTime.now();

  _submitForm() {
    final titulo = _tituloController.text;
    final valor = double.tryParse(_valorController.text) ?? 0.0;

    if (titulo.isEmpty || valor <= 0 || _dataSelecionada == null) {
      return;
    }

    widget.onSubmit(titulo, valor, _dataSelecionada!);
  }

  _showDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dataSelecionada = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              TextField(
                controller: _tituloController,
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                controller: _valorController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        _dataSelecionada == null
                            ? 'Nenhuma data selecionada'
                            : DateFormat('dd/MM/y').format(_dataSelecionada!),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent[800]),
                      onPressed: _showDataPicker,
                      child: const Text('Selecionar Data'),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _submitForm,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.greenAccent[900],
                    ),
                    child: const Text(
                      'Salvar Transação',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
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
