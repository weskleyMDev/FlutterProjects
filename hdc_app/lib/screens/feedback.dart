import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen(this.payload, {super.key});

  final String? payload;
  static const String routeName = '/feedback';

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late DatabaseReference dbRef;
  String? _payload;
  String? _opcao;
  String? _timeString;
  final _motivoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Feedbacks');
    _payload = widget.payload;
    _getCurrentTime();
  }

  _getCurrentTime() {
    setState(() {
      _timeString = DateFormat('dd-MM-y H:mm:ss').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: const Text(
          'Feedback',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Você já tomou "${_payload ?? ''}"?',
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                const Divider(
                  height: 50.0,
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 2.0,
                  color: Colors.blueGrey,
                ),
                RadioListTile(
                  title: const Text(
                    'Sim',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  value: 'sim',
                  groupValue: _opcao,
                  onChanged: (value) {
                    setState(
                      () => _opcao = value.toString(),
                    );
                    //selected value
                  },
                ),
                RadioListTile(
                  title: const Text(
                    'Não',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  value: 'não',
                  groupValue: _opcao,
                  onChanged: (value) {
                    setState(
                      () => _opcao = value.toString(),
                    );
                    //selected value
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _motivoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Se não, digite aqui o motivo...',
                    ),
                  ),
                ),
                const Divider(
                  height: 50.0,
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 2.0,
                  color: Colors.blueGrey,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 12.0,
                    ),
                  ),
                  onPressed: () {
                    Map<String, String> feedbacks = {
                      'Data': _timeString ?? '-',
                      'Remédio': _payload ?? '-',
                      'Resposta': _opcao ?? '-',
                      'Motivo': _motivoController.text.isEmpty
                          ? '-'
                          : _motivoController.text,
                    };
                    dbRef.push().set(feedbacks);
                    Fluttertoast.showToast(
                      msg: 'Obrigado pelo seu Feedback!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.send,
                  ),
                  label: const Text(
                    'Enviar',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
