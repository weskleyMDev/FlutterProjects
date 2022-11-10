import 'package:flutter/material.dart';

import '../data/radio_list.dart';

class AlarmModal extends StatefulWidget {
  const AlarmModal({super.key});

  @override
  State<AlarmModal> createState() => _AlarmModalState();
}

class _AlarmModalState extends State<AlarmModal> {
  int _value = 1;
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
                  border: OutlineInputBorder(
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
      ),
    );
  }
}
