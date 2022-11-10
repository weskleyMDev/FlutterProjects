import 'package:flutter/material.dart';

import '../data/radio_list.dart';

class AlarmModal extends StatefulWidget {
  const AlarmModal({super.key});

  @override
  State<AlarmModal> createState() => _AlarmModalState();
}

class _AlarmModalState extends State<AlarmModal> {
  int _value = 1;
  int _value2 = 1;
  bool isSwitched = false;

  List<DropdownMenuItem<String>> get dropdownItems1 {
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

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: 'Uma Dose',
        child: Text('Uma Dose'),
      ),
      const DropdownMenuItem(
        value: 'Duas Doses',
        child: Text('Duas Doses'),
      )
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: 'A Cada 6 Horas',
        child: Text('A Cada 6 Horas'),
      ),
      const DropdownMenuItem(
        value: 'A Cada 12 Horas',
        child: Text('A Cada 12 Horas'),
      )
    ];
    return menuItems;
  }

  String selectedValue1 = 'Toda Semana';
  String selectedValue2 = 'Uma Dose';
  String selectedValue3 = 'A Cada 6 Horas';

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
        child: SingleChildScrollView(
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
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.lightBlue,
                      width: 2.0,
                    ),
                  ),
                  labelText: 'Nome do Remédio',
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.lightBlue),
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
                      value: selectedValue1,
                      items: dropdownItems1,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue1 = newValue!;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyRadioListTile<int>(
                          value: 1,
                          groupValue: _value,
                          leading: 'D',
                          onChanged: (value) => setState(() => _value = value!),
                        ),
                        MyRadioListTile<int>(
                          value: 2,
                          groupValue: _value,
                          leading: 'S',
                          onChanged: (value) => setState(() => _value = value!),
                        ),
                        MyRadioListTile<int>(
                          value: 3,
                          groupValue: _value,
                          leading: 'T',
                          onChanged: (value) => setState(() => _value = value!),
                        ),
                        MyRadioListTile<int>(
                          value: 4,
                          groupValue: _value,
                          leading: 'Q',
                          onChanged: (value) => setState(() => _value = value!),
                        ),
                        MyRadioListTile<int>(
                          value: 5,
                          groupValue: _value,
                          leading: 'Q',
                          onChanged: (value) => setState(() => _value = value!),
                        ),
                        MyRadioListTile<int>(
                          value: 6,
                          groupValue: _value,
                          leading: 'S',
                          onChanged: (value) => setState(() => _value = value!),
                        ),
                        MyRadioListTile<int>(
                          value: 7,
                          groupValue: _value,
                          leading: 'S',
                          onChanged: (value) => setState(() => _value = value!),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: Colors.lightBlue),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTabController(
                      length: 2,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(5, 40, 46, 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            isScrollable: false,
                            unselectedLabelColor: Colors.grey,
                            labelColor: const Color.fromRGBO(5, 40, 46, 1),
                            tabs: const [
                              Tab(
                                child: Text(
                                  'Comprimido',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Líquido',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 2.0,
                            ),
                          ),
                          child: DropdownButton(
                            value: selectedValue2,
                            items: dropdownItems2,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue2 = newValue!;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 2.0,
                            ),
                          ),
                          child: DropdownButton(
                            value: selectedValue3,
                            items: dropdownItems3,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue3 = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _value2,
                          onChanged: (value) {
                            setState(() {
                              _value2 = value!;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.lightBlue[300],
                          ),
                          child: const Text('6:00'),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        const Text(
                          'Descrição...',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_note),
                          iconSize: 30.0,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: _value2,
                          onChanged: (value) {
                            setState(() {
                              _value2 = value!;
                            });
                          },
                          activeColor: Colors.black,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.lightBlue[300],
                          ),
                          child: const Text('12:00'),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        const Text(
                          'Descrição...',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_note),
                          iconSize: 30.0,
                        ),
                      ],
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
                      horizontal: 150.0,
                      vertical: 15,
                    ),
                    shape: const StadiumBorder(),
                    backgroundColor: const Color.fromRGBO(5, 40, 46, 1),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18)),
                child: const Text(
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
