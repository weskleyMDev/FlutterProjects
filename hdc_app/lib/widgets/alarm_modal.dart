import 'package:flutter/material.dart';

class AlarmModal extends StatefulWidget {
  const AlarmModal({super.key});

  @override
  State<AlarmModal> createState() => _AlarmModalState();
}

class _AlarmModalState extends State<AlarmModal> {
  bool isSwitched = false;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: 'Toda Semana',
        child: Text('Toda Semana'),
      ),
      const DropdownMenuItem(
        value: 'Todo Dia',
        child: Text('Todo Dia'),
      )
    ];
    return menuItems;
  }

  String selectedValue = 'Toda Semana';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 720,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(231, 249, 251, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Criar Alarme',
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
            const TextField(),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Vibrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.blueGrey[900],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Repetir',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.blueGrey[900],
                      )
                    ],
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.lightBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.lightBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    value: selectedValue,
                    items: dropdownItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    dropdownColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Dias da Semana',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 155.0,
                  vertical: 15,
                ),
                shape: const StadiumBorder(),
                backgroundColor: const Color.fromRGBO(5, 40, 46, 1),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Salvar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
