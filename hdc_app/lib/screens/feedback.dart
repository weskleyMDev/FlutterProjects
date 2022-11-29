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
      backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: const Text(
          'Feedback',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(5, 40, 46, 1),
          ),
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
                    color: Color.fromRGBO(5, 40, 46, 1),
                  ),
                ),
                Divider(
                  height: 50.0,
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 2.0,
                  color: Colors.lightBlue[200],
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
                  activeColor: Colors.lightBlue,
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
                  activeColor: Colors.lightBlue,
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
                      prefixIcon: Icon(
                        Icons.edit_rounded,
                        color: Colors.lightBlue,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color.fromRGBO(5, 40, 46, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.lightBlue,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.lightBlue,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 50.0,
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 2.0,
                  color: Colors.lightBlue[200],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(5, 40, 46, 1),
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
                    'ENVIAR',
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
